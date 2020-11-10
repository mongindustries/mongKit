//
//  ConstructorComponentBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
import mongKitCore

internal struct StyleWrapper {

  let config: ErasedStyleConfiguration

  init<Target: StyleConfiguration>(_ style: Target) {
    config = .init(style)
  }
}

fileprivate var constructedKey = 0x1000_1118
fileprivate var viewlayout_Key = 0x1000_0911

fileprivate var style______Key = 0x1000_abcd

extension UIView {

  var layout          : LayoutConfiguration? {
    get {
      objc_getAssociatedObject(self, &viewlayout_Key) as? LayoutConfiguration }
    set {
      objc_setAssociatedObject(self, &viewlayout_Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  var style           : StyleWrapper? {
    get {
      objc_getAssociatedObject(self, &style______Key) as? StyleWrapper }
    set {
      objc_setAssociatedObject(self, &style______Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
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
        sview.style?.config.apply(sview)
        sview.style = nil
      }

    case let block as Components.Group:
      block.items.forEach {
        buildChildren($0)
      }

    case let block as Components.Redirect:
      buildChildren(block.item())

    case let block as ChoiceResolverComponent:
      buildChildren(block.result)

    default:
      fatalError()
    }
  }


  public var mongConstructed  : Bool {
    get { objc_getAssociatedObject(self, &constructedKey) as? Bool ?? false }
    set { objc_setAssociatedObject(self, &constructedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  public convenience init<StyleConfig: StyleConfiguration>(
    style                         : StyleConfig,
    layout                        : LayoutConfiguration = FrameLayout(frame: .zero),
    @ComponentBuilder _ children  : () -> Component) {
    self.init(frame: .zero)

    mongConstructed = true

    self.layout       = layout
    self.style        = StyleWrapper(style)
    
    buildChildren     (children())
  }
  
  public convenience init<StyleConfig: StyleConfiguration>(
    style                         : StyleConfig,
    layout                        : LayoutConfiguration = FrameLayout(frame: .zero)) {
    self.init(frame: .zero)

    mongConstructed = true

    self.layout       = layout
    self.style        = StyleWrapper(style)
  }
}
