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

  public init() {
    constraint = { view in
      return [view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor)]
    }
  }


  public init(equalTo target: @autoclosure @escaping () -> HorizontalConstraint, @ConstraintModifierBuilder _ modifier: () -> ConstraintModifier) {
    constraint = { view in [generateEqualConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())] }
  }

  public init(equalTo target: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { view in [generateEqualConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())] }
  }


  public init(greaterThan target: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {
    constraint = { view in [generateGreaterConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())] }
  }

  public init(greaterThan target: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { view in [generateGreaterConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())] }
  }


  public init(lessThan target: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {
    constraint = { view in [generateLesserConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())] }
  }

  public init(lessThan target: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { view in [generateLesserConstraint(for: view, \.trailingAnchor, \.trailingAnchor, to: target())] }
  }
}
