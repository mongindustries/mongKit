//
//  Leading.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Leading: Constraint, HorizontalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      [ tell(view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor)) {
        modifiers.apply(target: Leading.self, $0) } ] }
  }

  public init(equalTo     target                    : @autoclosure @escaping () -> HorizontalConstraint,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      [ tell(generateEqualConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target())) {
        modifiers.apply(target: Leading.self, $0) } ] }
  }

  public init(greaterThan target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      [ tell(generateGreaterConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target(), multiplier: multiplier)) {
        modifiers.apply(target: Leading.self, $0) }] }
  }

  public init(lessThan    target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { view in
      [ tell(generateLesserConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target(), multiplier: multiplier)) {
        modifiers.apply(target: Leading.self, $0) }] }
  }
}
