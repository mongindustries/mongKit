//
//  UIView+Style.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Ref<Target: UIView>: StyleConfiguration {
  public typealias Comp = Target

  public let value: (Target) -> Void

  public init(_ action: @escaping (Target) -> Void) {
    self.value = action
  }

  public init(to target: UnsafeMutablePointer<Target>) {
    self.value = { view in
      target.pointee = view
    }
  }

  public func apply(_ target: Target) {
    value(target)
  }
}

public struct BackgroundColor<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: UIColor

  public init(value: UIColor) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.backgroundColor = value
  }
}

public struct Opacity<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: CGFloat

  public init(value: CGFloat) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.alpha = value
  }
}

public struct Hidden<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: Bool

  public init(value: Bool) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.isHidden = value
  }
}

public struct Visible<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: Bool

  public init(value: Bool) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.isHidden = !value
  }
}

public struct Tint<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: UIColor

  public init(value: UIColor) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.tintColor = value
  }
}

public struct InteractionEnabled<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: Bool

  public init(value: Bool) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.isUserInteractionEnabled = value
  }
}

public struct Frame<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: CGRect

  public init(value: CGRect) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.frame = value
  }
}

public struct Bounds<View: UIView>: StyleConfiguration {
  public typealias Comp = View

  public let value: CGRect

  public init(value: CGRect) {
    self.value = value
  }

  public func apply(_ target: View) {
    target.bounds = value
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

public func ==><View: UIView, Prop>(_ prop: ReferenceWritableKeyPath<View, Prop>, _ value: Prop) -> Property<View, Prop> {
  .init(prop, value: value)
}
