//
//  UIView+Style.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

extension Ref: Configuration where Target: UIView { }

extension Ref: StyleConfiguration where Target: UIView {
  public typealias Comp = Target

  public init(_ action: @escaping (Target) -> Void) {
    __apply = { any in action(any as! Target) }
  }

  public init<Owner: AnyObject>(_ target: Owner, ref: ReferenceWritableKeyPath<Owner, Target?>) {

    let weak = Weak(wrappedValue: target)
    __apply = { view in
      weak.wrappedValue?[keyPath: ref] = .some(view as! Target)
    }
  }

  public func apply(_ target: Target) {
    __apply(target)
  }
}

public struct Property<View: UIView, Prop>: StyleConfiguration {
  public typealias Comp = View

  let prop: ReferenceWritableKeyPath<View, Prop>
  public let value: Prop

  public init(_ prop: ReferenceWritableKeyPath<View, Prop>, value: Prop) {
    self.prop = prop
    self.value = value
  }

  public func apply(_ target: View) {
    target[keyPath: prop] = value
  }
}

infix operator ==>

@available(*, deprecated, renamed: "~")
public func ==><View: UIView, Prop>(_ prop: ReferenceWritableKeyPath<View, Prop>, _ value: Prop) -> Property<View, Prop> {
  .init(prop, value: value)
}

infix operator ~

public func ~ <View: UIView, Prop>(_ prop: ReferenceWritableKeyPath<View, Prop>, _ value: Prop) -> Property<View, Prop> {
  .init(prop, value: value)
}
