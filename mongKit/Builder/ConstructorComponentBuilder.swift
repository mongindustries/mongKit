//
//  ConstructorComponentBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

fileprivate var constructedKey = 0x1000_1118
fileprivate var viewlayout_Key = 0x1000_0911
fileprivate var sublayout__Key = 0x1000_ffff

fileprivate var style______Key = 0x1000_abcd

struct SublayoutApply {
  weak var view: UIView?
  let layout: Layout
}

@_functionBuilder
public struct ConstructorComponentBuilder {

  public static func buildExpression<C: Component>(_ component: @escaping @autoclosure () -> C) -> Component {
    RedirectComponent(item: component)
  }

  public static func buildExpression(_ style: Style) -> Style {
    style
  }

  public static func buildExpression(_ layout: Layout) -> Layout {
    layout
  }


  public static func buildBlock(_ style: Style) -> Style {
    style
  }

  public static func buildBlock(_ style: Style, _ children: Component...) -> ConstructorComponent {
    .init(style: style, layout: .init(), children: { GroupComponent(items: children) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { EmptyComponent() })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout, _ children: Component...) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { GroupComponent(items: children) })
  }
}

extension UIView {

  public var mongConstructed: Bool {
    get { objc_getAssociatedObject(self, &constructedKey) as? Bool ?? false }
    set { objc_setAssociatedObject(self, &constructedKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }

  var layout: Layout? {
    get { objc_getAssociatedObject(self, &viewlayout_Key) as? Layout }
    set { objc_setAssociatedObject(self, &viewlayout_Key, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }

  var sublayouts: [SublayoutApply] {
    get { objc_getAssociatedObject(self, &sublayout__Key) as? [SublayoutApply] ?? [] }
    set { objc_setAssociatedObject(self, &sublayout__Key, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }

  var styleConfig: [AnyStyleConfiguration] {
    get { objc_getAssociatedObject(self, &style______Key) as? [AnyStyleConfiguration] ?? [] }
    set { objc_setAssociatedObject(self, &style______Key, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }

  public convenience init(@ConstructorComponentBuilder _ builder: () -> Style) {
    self.init(frame: .zero)

    mongConstructed = true

    styleConfig = builder().styles
  }

  public convenience init(@ConstructorComponentBuilder _ builder: () -> ConstructorComponent) {
    self.init(frame: .zero)

    mongConstructed = true

    let config = builder()

    layout = config.layout // defer execution of layout instructions
    styleConfig = config.style.styles

    buildChildren(config.children())
  }

  func climbLayout(_ target: UIView) {
    if let layout = target.layout, let parent = target.superview {
      parent.sublayouts.append(SublayoutApply(view: target, layout: layout))
      parent.sublayouts.append(contentsOf: target.sublayouts)
    }
  }

  func buildChildren(_ component: Component) {

    switch component {
    case let sview as UIView:
      if let stack = self as? UIStackView {
        stack.addArrangedSubview(sview)
      } else {
        addSubview(sview)
      }

      if sview.mongConstructed {
        for config in sview.styleConfig {
          config.apply(sview)
        }
      }

      climbLayout(sview)

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
}
