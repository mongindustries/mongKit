//
//  CenterY.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

public struct CenterY: Constraint, VerticalConstraintConstructible {

  public static func equalTo<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : VerticalConstraint {
    
    let target      = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> NSLayoutConstraint in
      let     dest = convertVerticalConstraint(target.wrappedValue![keyPath: constraint.wrappedValue!], viewSelector: \.centerYAnchor, guideSelector: \.centerYAnchor)
      return  tell(view.wrappedValue!.centerYAnchor.constraint(equalTo: dest)) {
        builder().apply(target: CenterY.self, $0)
      }
    }
  }

  public static func lessThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : VerticalConstraint {
    
    let target      = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> NSLayoutConstraint in
      let     dest = convertVerticalConstraint(target.wrappedValue![keyPath: constraint.wrappedValue!], viewSelector: \.centerYAnchor, guideSelector: \.centerYAnchor)
      return  tell(view.wrappedValue!.centerYAnchor.constraint(lessThanOrEqualTo: dest)) {
        builder().apply(target: CenterY.self, $0)
      }
    }
  }
  
  public static func moreThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : VerticalConstraint {
    
    let target      = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)

    return Raw { view -> NSLayoutConstraint in
      let     dest = convertVerticalConstraint(target.wrappedValue![keyPath: constraint.wrappedValue!], viewSelector: \.centerYAnchor, guideSelector: \.centerYAnchor)
      return  tell(view.wrappedValue!.centerYAnchor.constraint(greaterThanOrEqualTo: dest)) {
        builder().apply(target: CenterY.self, $0)
      }
    }
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(target.wrappedValue!.centerYAnchor.constraint(equalTo: target.wrappedValue!.superview!.centerYAnchor)) {
        modifiers.apply(target: CenterY.self, $0) } ] }
  }

  public init(equalTo      anchor                  : @autoclosure @escaping () -> VerticalConstraint,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateEqualConstraint(for: target.wrappedValue!, \.centerYAnchor, \.centerYAnchor, to: anchor())) {
        modifiers.apply(target: CenterY.self, $0) } ] }
  }

  public init(greaterThan  anchor                  : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateGreaterConstraint(for: target.wrappedValue!, \.centerYAnchor, \.centerYAnchor, to: anchor(), multiplier: multiplier)) {
        modifiers.apply(target: CenterY.self, $0) } ] }
  }

  public init(lessThan     anchor                  : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateLesserConstraint(for: target.wrappedValue!, \.centerYAnchor, \.centerYAnchor, to: anchor(), multiplier: multiplier)) {
        modifiers.apply(target: CenterY.self, $0) } ]
    }
  }
}
