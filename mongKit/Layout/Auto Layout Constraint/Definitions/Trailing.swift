//
//  Trailing.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Trailing: Constraint, HorizontalConstraintConstructible {
  
  public static func equalTo<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {
    
    let target = Weak(wrappedValue: target)
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.trailingAnchor, guideSelector: \.trailingAnchor)

      return [
        tell(view.trailingAnchor.constraint(equalTo: dest)) {
          builder().apply(target: Leading.self, $0) }
      ]
    }
  }
  
  public static func lessThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {
    
    let target = Weak(wrappedValue: target)
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.trailingAnchor, guideSelector: \.trailingAnchor)

      return [
        tell(view.trailingAnchor.constraint(lessThanOrEqualTo: dest)) {
          builder().apply(target: Leading.self, $0) }
      ]
    }
  }
  
  public static func moreThan<Target, TConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) -> Constraint where Target : NSObject, TConstraint : HorizontalConstraint {
    
    let target = Weak(wrappedValue: target)
    return Raw { view -> [NSLayoutConstraint] in
      guard let view    = view  .wrappedValue,
            let target  = target.wrappedValue else { fatalError("Prerequisites not satisfied!") }

      let mx    = target[keyPath: constraint]
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.trailingAnchor, guideSelector: \.trailingAnchor)

      return [
        tell(view.trailingAnchor.constraint(greaterThanOrEqualTo: dest)) {
          builder().apply(target: Leading.self, $0) }
      ]
    }
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]


  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }
      
      return [ tell(view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor)) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }

  public init(equalTo     target                    : @autoclosure @escaping () -> HorizontalConstraint,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }
      
      return [ tell(generateEqualConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }

  public init(greaterThan target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }
      
      return [ tell(generateGreaterConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }

  public init(lessThan    target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }
      
      return [ tell(generateLesserConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }
}
