//
//  CenterX.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

public struct CenterX: Constraint, HorizontalConstraintConstructible {
  
  public static func equalTo<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {

    let target      = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint.wrappedValue!]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.centerXAnchor, guideSelector: \.centerXAnchor)

      return [
        tell(view.centerXAnchor.constraint(equalTo: dest)) {
          builder().apply(target: CenterX.self, $0) }
      ]
    }
  }
  
  public static func lessThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {
    
    let target      = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint.wrappedValue!]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.centerXAnchor, guideSelector: \.centerXAnchor)

      return [
        tell(view.centerXAnchor.constraint(lessThanOrEqualTo: dest)) {
          builder().apply(target: CenterX.self, $0) }
      ]
    }
  }
  
  public static func moreThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {

    let target      = Weak(wrappedValue: target)
    let constraint  = Weak(wrappedValue: constraint)
    
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint.wrappedValue!]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.centerXAnchor, guideSelector: \.centerXAnchor)

      return [
        tell(view.centerXAnchor.constraint(greaterThanOrEqualTo: dest)) {
          builder().apply(target: CenterX.self, $0) }
      ]
    }
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]
  
  public init(@ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(target.wrappedValue!.centerXAnchor.constraint(equalTo: target.wrappedValue!.superview!.centerXAnchor)) {
          modifiers.apply(target: CenterX.self, $0) } ] }
  }
  
  public init(equalTo      anchor                  : @autoclosure @escaping () -> HorizontalConstraint,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(generateEqualConstraint(for: target.wrappedValue!, \.centerXAnchor, \.centerXAnchor, to: anchor())) {
          modifiers.apply(target: CenterX.self, $0) } ] }
  }
  
  public init(greaterThan  anchor                  : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(generateGreaterConstraint(for: target.wrappedValue!, \.centerXAnchor, \.centerXAnchor, to: anchor(), multiplier: multiplier)) {
          modifiers.apply(target: CenterX.self, $0) } ] }
  }
  
  public init(lessThan     anchor                  : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(generateLesserConstraint(for: target.wrappedValue!, \.centerXAnchor, \.centerXAnchor, to: anchor(), multiplier: multiplier)) {
          modifiers.apply(target: CenterX.self, $0) } ]
    }
  }
}
