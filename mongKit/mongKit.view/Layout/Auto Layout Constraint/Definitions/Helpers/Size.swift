//
//  Size.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

public struct Size: Constraint {
  
  public var constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(_ value                               : CGFloat,
              @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    constraint = { target in
      return Width(value, builder).constraint(target) +
            Height(value, builder).constraint(target)
    }
  }

  public init(_ size                                : CGSize,
              @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    constraint = { target in
      return Width(size.width,  builder).constraint(target) +
            Height(size.height, builder).constraint(target)
    }
  }

  public init<Target: UIView>(
    _ target                              : Target,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let weak = Weak(wrappedValue: target)
    constraint = { target in

      guard let view = weak.wrappedValue else { fatalError() }

      return
        Height  .equalTo(view, constraint: \UIView.heightAnchor , builder).constraint(target) +
        Width   .equalTo(view, constraint: \UIView.widthAnchor  , builder).constraint(target)
    }
  }
  
  public init<Target: UILayoutGuide>(
    _ target                              : Target,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let weak = Weak(wrappedValue: target)
    constraint = { target in

      guard let view = weak.wrappedValue else { fatalError() }

      return
        Height  .equalTo(view, constraint: \UILayoutGuide.heightAnchor , builder).constraint(target) +
        Width   .equalTo(view, constraint: \UILayoutGuide.widthAnchor  , builder).constraint(target)
    }
  }
}
