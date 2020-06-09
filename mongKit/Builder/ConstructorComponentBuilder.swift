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

struct SublayoutApply {
  weak var view: UIView?
  let layout: Layout
}

@_functionBuilder
public struct ConstructorComponentBuilder {

  public static func buildBlock(_ style: Style) -> Style {
    style
  }

  public static func buildBlock(_ style: Style, _ layout: Layout) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { EmptyComponent() })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component,
    _ c4: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3(), c4() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component,
    _ c4: @autoclosure @escaping () -> Component,
    _ c5: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3(), c4(), c5() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component,
    _ c4: @autoclosure @escaping () -> Component,
    _ c5: @autoclosure @escaping () -> Component,
    _ c6: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3(), c4(), c5(), c6() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component,
    _ c4: @autoclosure @escaping () -> Component,
    _ c5: @autoclosure @escaping () -> Component,
    _ c6: @autoclosure @escaping () -> Component,
    _ c7: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3(), c4(), c5(), c6(), c7() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component,
    _ c4: @autoclosure @escaping () -> Component,
    _ c5: @autoclosure @escaping () -> Component,
    _ c6: @autoclosure @escaping () -> Component,
    _ c7: @autoclosure @escaping () -> Component,
    _ c8: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3(), c4(), c5(), c6(), c7(), c8() ]) })
  }

  public static func buildBlock(_ style: Style, _ layout: Layout,
    _ c0: @autoclosure @escaping () -> Component,
    _ c1: @autoclosure @escaping () -> Component,
    _ c2: @autoclosure @escaping () -> Component,
    _ c3: @autoclosure @escaping () -> Component,
    _ c4: @autoclosure @escaping () -> Component,
    _ c5: @autoclosure @escaping () -> Component,
    _ c6: @autoclosure @escaping () -> Component,
    _ c7: @autoclosure @escaping () -> Component,
    _ c8: @autoclosure @escaping () -> Component,
    _ c9: @autoclosure @escaping () -> Component) -> ConstructorComponent {
    .init(style: style, layout: layout, children: { ArrayComponent(items: [ c0(), c1(), c2(), c3(), c4(), c5(), c6(), c7(), c8(), c9() ]) })
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

  public convenience init(@ConstructorComponentBuilder _ builder: () -> Style) {
    self.init(frame: .zero)

    mongConstructed = true

    builder().styles.forEach { $0.apply(self) }
  }

  public convenience init(@ConstructorComponentBuilder _ builder: () -> ConstructorComponent) {
    self.init(frame: .zero)

    mongConstructed = true

    let config = builder()

    layout = config.layout // defer execution of layout instructions
    config.style.styles.forEach { $0.apply(self) }

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

      climbLayout(sview)

    case let array as ArrayComponent:
      array.items.forEach {
        buildChildren($0)
      }

    case let choice as ChoiceResolverComponent:
      buildChildren(choice.result)

    default:
      break
    }
  }
}
