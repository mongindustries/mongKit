//
//  CenterY.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct CenterY: Constraint, VerticalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(target.centerYAnchor.constraint(equalTo: target.superview!.centerYAnchor)) {
        modifiers.apply(target: CenterY.self, $0) } ] }
  }

  public init(equalTo      anchor                  : @autoclosure @escaping () -> VerticalConstraint,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateEqualConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor())) {
        modifiers.apply(target: CenterY.self, $0) } ] }
  }

  public init(greaterThan  anchor                  : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateGreaterConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor(), multiplier: multiplier)) {
        modifiers.apply(target: CenterY.self, $0) } ] }
  }

  public init(lessThan     anchor                  : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateLesserConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor(), multiplier: multiplier)) {
        modifiers.apply(target: CenterY.self, $0) } ]
    }
  }
}
