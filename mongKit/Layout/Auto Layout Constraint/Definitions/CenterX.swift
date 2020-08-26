//
//  CenterX.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct CenterX: Constraint, HorizontalConstraintConstructible {
  
  public static func equalTo<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {

    let target = Weak(wrappedValue: target)
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.centerXAnchor, guideSelector: \.centerXAnchor)

      return [
        tell(view.centerXAnchor.constraint(equalToSystemSpacingAfter: dest, multiplier: multiplier)) {
          builder().apply(target: CenterX.self, $0) }
      ]
    }
  }
  
  public static func lessThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {
    
    let target = Weak(wrappedValue: target)
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.centerXAnchor, guideSelector: \.centerXAnchor)

      return [
        tell(view.centerXAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: dest, multiplier: multiplier)) {
          builder().apply(target: CenterX.self, $0) }
      ]
    }
  }
  
  public static func moreThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    multiplier                            : CGFloat = 1,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {

    let target = Weak(wrappedValue: target)
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.centerXAnchor, guideSelector: \.centerXAnchor)

      return [
        tell(view.centerXAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: dest, multiplier: multiplier)) {
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
