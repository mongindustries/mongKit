//
//  Trailing.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Trailing: Constraint, HorizontalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { view in
      [ tell(view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor)) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }

  public init(equalTo     target                    : @autoclosure @escaping () -> HorizontalConstraint,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { view in
      [ tell(generateEqualConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }

  public init(greaterThan target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { view in
      [ tell(generateGreaterConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }

  public init(lessThan    target                    : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { view in
      [ tell(generateLesserConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target(), multiplier: multiplier)) {
        modifier.apply(target: Trailing.self, $0) } ] }
  }
}
