//
//  Height.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public struct Height: Constraint {
  
  public static func equalTo<Target: AnyObject>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, NSLayoutDimension>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint {

    let weak = Weak(wrappedValue: target)
    return Raw { view -> NSLayoutConstraint in

      let dimension = weak.wrappedValue![keyPath: constraint]

      return tell(view.wrappedValue!.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier)) {
        builder().apply(target: Height.self, $0)
      }
    }
  }
  
  public static func lessThan<Target: AnyObject>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, NSLayoutDimension>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint {

    let weak = Weak(wrappedValue: target)
    return Raw { view -> NSLayoutConstraint in

      let dimension = weak.wrappedValue![keyPath: constraint]

      return tell(view.wrappedValue!.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier)) {
        builder().apply(target: Height.self, $0)
      }
    }
  }
  
  public static func moreThan<Target: AnyObject>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, NSLayoutDimension>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint {

    let weak = Weak(wrappedValue: target)
    return Raw { view -> NSLayoutConstraint in

      let dimension = weak.wrappedValue![keyPath: constraint]

      return tell(view.wrappedValue!.heightAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier)) {
        builder().apply(target: Height.self, $0)
      }
    }
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder: () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.wrappedValue!.heightAnchor.constraint(equalTo: target.wrappedValue!.superview!.heightAnchor)) {
        modifier.apply(target: Height.self, $0) } ]
    }
  }
  
  public init(_ value                               : CGFloat,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()

    constraint = { target in
      [ tell(target.wrappedValue!.heightAnchor.constraint(equalToConstant: value)) {
        modifier.apply(target: Height.self, $0) } ]
    }
  }
}
