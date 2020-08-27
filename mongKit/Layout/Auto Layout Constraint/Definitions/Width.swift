//
//  Width.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public struct Width: Constraint {

  public static func equalTo<Target: AnyObject>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, NSLayoutDimension>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint {

    let weak        = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> NSLayoutConstraint in

      let dimension = weak.wrappedValue![keyPath: constraint.wrappedValue!]

      return tell(view.wrappedValue!.widthAnchor.constraint(equalTo: dimension, multiplier: multiplier)) {
        builder().apply(target: Width.self, $0)
      }
    }
  }
  
  public static func lessThan<Target: AnyObject>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, NSLayoutDimension>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint {

    let weak        = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> NSLayoutConstraint in

      let dimension = weak.wrappedValue![keyPath: constraint.wrappedValue!]

      return tell(view.wrappedValue!.widthAnchor.constraint(equalTo: dimension, multiplier: multiplier)) {
        builder().apply(target: Width.self, $0)
      }
    }
  }
  
  public static func moreThan<Target: AnyObject>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, NSLayoutDimension>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint {

    let weak        = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> NSLayoutConstraint in

      let dimension = weak.wrappedValue![keyPath: constraint.wrappedValue!]

      return tell(view.wrappedValue!.widthAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier)) {
        builder().apply(target: Width.self, $0)
      }
    }
  }
  
  
  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.wrappedValue!.widthAnchor.constraint(equalTo: target.wrappedValue!.superview!.widthAnchor)) {
        modifier.apply(target: Width.self, $0) } ]
    }
  }
  
  public init(_ dimension                           : KeyPath<UIView, NSLayoutDimension>,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier  = builder()
    let dimension = Weak(wrappedValue: dimension)

    constraint = { target in
      [ tell(target.wrappedValue!.widthAnchor.constraint(equalTo: target.wrappedValue![keyPath: dimension.wrappedValue!], multiplier: multiplier)) {
        modifier.apply(target: Width.self, $0) } ]
    }
  }

  public init(_ value                               : CGFloat,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.wrappedValue!.widthAnchor.constraint(equalToConstant: value)) {
        modifier.apply(target: Width.self, $0) } ]
    }
  }
}
