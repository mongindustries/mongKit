//
//  ConstructorComponentBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

fileprivate var constructedKey = 0x1000_1118
fileprivate var viewlayout_Key = 0x1000_0911

fileprivate var style______Key = 0x1000_abcd

struct BlankLayout: LayoutConfiguration {
  func apply(_ target: UIView) {
  }
}

@_functionBuilder
public struct ConstructorComponentBuilder {

  public static func buildExpression<C: Component>(_ component: @escaping @autoclosure () -> C) -> Component {
    RedirectComponent(item: component)
  }

  public static func buildExpression(_ style: Style) -> Style {
    style
  }

  public static func buildExpression(_ layout: LayoutConfiguration) -> LayoutConfiguration {
    layout
  }


  public static func buildBlock(_ style: Style) -> Style {
    style
  }

  public static func buildBlock(_ style: Style, _ children: Component...) -> ConstructorComponent {
    .init(style: style, layout: BlankLayout(), children: { GroupComponent(items: children) })
  }

  public static func buildBlock(_ style: Style, _ layout: LayoutConfiguration) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { EmptyComponent() })
  }

  public static func buildBlock(_ style: Style, _ layout: LayoutConfiguration, _ children: Component...) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { GroupComponent(items: children) })
  }
}

extension UIView {

  var layout          : Any? {
    get {
      objc_getAssociatedObject(self, &viewlayout_Key) }
    set {
      objc_setAssociatedObject(self, &viewlayout_Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  var styleConfig     : [AnyStyleConfiguration] {
    get { objc_getAssociatedObject(self, &style______Key) as? [AnyStyleConfiguration] ?? [] }
    set { objc_setAssociatedObject(self, &style______Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  func buildChildren  (_ component: Component) {

    switch component {
    case let sview as UIView:
      
      switch self {
      case let stack as UIStackView:
        stack.addArrangedSubview(sview)
      case let effect as UIVisualEffectView:
        effect.contentView.addSubview(sview)
      default:
        addSubview(sview)
      }

      if sview.mongConstructed {
        for config in sview.styleConfig {
          config.apply(sview)
        }
      }

    case let array as GroupComponent:
      array.items.forEach {
        buildChildren($0)
      }

    case let choice as ChoiceResolverComponent:
      buildChildren(choice.result)

    case let redirect as RedirectComponent:
      buildChildren(redirect.item())

    default:
      break
    }
  }


  @available(*, deprecated, message: "Use constructor with explicit construction parameters.")
  public convenience init(@ConstructorComponentBuilder _ builder: () -> Style) {
    self.init(frame: .zero)

    mongConstructed = true
    styleConfig = builder().styles
  }

  @available(*, deprecated, message: "Use constructor with explicit construction parameters.")
  public convenience init(@ConstructorComponentBuilder _ builder: () -> ConstructorComponent) {
    self.init(frame: .zero)

    mongConstructed = true

    let config = builder()

    layout      = config.layout // defer execution of layout instructions
    styleConfig = config.style.styles

    buildChildren(config.children())
  }


  public var mongConstructed  : Bool {
    get { objc_getAssociatedObject(self, &constructedKey) as? Bool ?? false }
    set { objc_setAssociatedObject(self, &constructedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  public convenience init     (
    style                         : @autoclosure () -> Style = { Style() }(),
    layout                        : @autoclosure () -> LayoutConfiguration = { FrameLayout(frame: .zero) }(),
    @ComponentBuilder _ children  : () -> Component) {
    self.init(frame: .zero)

    mongConstructed = true

    self.layout       = layout()
    self.styleConfig  = style ().styles

    buildChildren     (children())
  }
  
  public convenience init     (
    style                         : @autoclosure () -> Style = { Style() }(),
    layout                        : @autoclosure () -> LayoutConfiguration = { FrameLayout(frame: .zero) }()) {
    self.init(frame: .zero)

    mongConstructed = true

    self.layout       = layout()
    self.styleConfig  = style ().styles
  }
}
