//
//  Leading.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Leading: Constraint, HorizontalConstraintConstructible {

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
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.leadingAnchor, guideSelector: \.leadingAnchor)

      return [
        tell(view.leadingAnchor.constraint(equalToSystemSpacingAfter: dest, multiplier: multiplier)) {
          builder().apply(target: Leading.self, $0) }
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
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.leadingAnchor, guideSelector: \.leadingAnchor)

      return [
        tell(view.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: dest, multiplier: multiplier)) {
          builder().apply(target: Leading.self, $0) }
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
      let dest  = convertHorizontalConstraint(mx, viewSelector: \.leadingAnchor, guideSelector: \.leadingAnchor)

      return [
        tell(view.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: dest, multiplier: multiplier)) {
          builder().apply(target: Leading.self, $0) }
      ]
    }
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }

      return [
        tell(view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor)) {
          modifiers.apply(target: Leading.self, $0) } ] }
  }

  public init(equalTo     target                    : @autoclosure @escaping () -> HorizontalConstraint,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }

      return [
        tell(generateEqualConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target())) {
          modifiers.apply(target: Leading.self, $0) } ] }
  }

  public init(greaterThan target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }
      
      return [
        tell(generateGreaterConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target(), multiplier: multiplier)) {
        modifiers.apply(target: Leading.self, $0) }] }
  }

  public init(lessThan    target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      
      guard let view = view.wrappedValue else {
        return []
      }
      
      return [
        tell(generateLesserConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target(), multiplier: multiplier)) {
          modifiers.apply(target: Leading.self, $0) }] }
  }
}
