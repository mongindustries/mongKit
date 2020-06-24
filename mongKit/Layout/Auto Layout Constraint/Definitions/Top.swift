//
//  Top.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Top: Constraint, VerticalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(view.topAnchor.constraint(equalTo: view.superview!.topAnchor)) {
        modifier.apply(target: Top.self, $0) } ] }
  }

  public init(equalTo target                        : @autoclosure @escaping () -> VerticalConstraint,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(generateEqualConstraint(for: view, \.topAnchor, \.topAnchor, to: target())) {
        modifier.apply(target: Top.self, $0) } ] }
  }

  public init(greaterThan target                    : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(generateGreaterConstraint(for: view, \.topAnchor, \.topAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Top.self, $0) } ] }
  }

  public init(lessThan target                       : @autoclosure @escaping () -> VerticalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(generateLesserConstraint(for: view, \.topAnchor, \.topAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Top.self, $0) } ] }
  }
}
