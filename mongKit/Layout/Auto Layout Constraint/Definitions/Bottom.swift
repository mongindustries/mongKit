//
//  Bottom.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Bottom: Constraint, VerticalConstraintConstructible {

  public static func equalTo<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : VerticalConstraint {

    let weak        = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)

    return Raw { view -> NSLayoutConstraint in
      let     dest = convertVerticalConstraint(weak.wrappedValue![keyPath: constraint.wrappedValue!], viewSelector: \.bottomAnchor, guideSelector: \.bottomAnchor)
      return  tell(view.wrappedValue!.bottomAnchor.constraint(equalTo: dest)) {
        builder().apply(target: Bottom.self, $0)
      }
    }
  }
  
  public static func lessThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : VerticalConstraint {

    let weak        = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)

    return Raw { view -> NSLayoutConstraint in
      let     dest = convertVerticalConstraint(weak.wrappedValue![keyPath: constraint.wrappedValue!], viewSelector: \.bottomAnchor, guideSelector: \.bottomAnchor)
      return  tell(view.wrappedValue!.bottomAnchor.constraint(lessThanOrEqualTo: dest)) {
        builder().apply(target: Bottom.self, $0)
      }
    }
  }
  
  public static func moreThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : VerticalConstraint {
    
    let weak        = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> NSLayoutConstraint in
      let     dest = convertVerticalConstraint(weak.wrappedValue![keyPath: constraint.wrappedValue!], viewSelector: \.bottomAnchor, guideSelector: \.bottomAnchor)
      return  tell(view.wrappedValue!.bottomAnchor.constraint(greaterThanOrEqualTo: dest)) {
        builder().apply(target: Bottom.self, $0)
      }
    }
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(view.wrappedValue!.bottomAnchor.constraint(equalTo: view.wrappedValue!.superview!.bottomAnchor)) {
        modifier.apply(target: Bottom.self, $0) } ] }
  }

  public init(equalTo target                        : @autoclosure @escaping () -> VerticalConstraint,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(generateEqualConstraint(for: view.wrappedValue!, \.bottomAnchor, \.bottomAnchor, to: target())) {
        modifier.apply(target: Bottom.self, $0) } ] }
  }

  public init(greaterThan target                    : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(generateGreaterConstraint(for: view.wrappedValue!, \.bottomAnchor, \.bottomAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Bottom.self, $0) } ] }
  }

  public init(lessThan target                       : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(generateLesserConstraint(for: view.wrappedValue!, \.bottomAnchor, \.bottomAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Bottom.self, $0) } ] }
  }
}
