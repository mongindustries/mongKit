//
//  Top.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Top: Constraint, VerticalConstraintConstructible {

  public let constraint: (UIView) -> NSLayoutConstraint

  public init() {
    constraint = { view in
      return view.topAnchor.constraint(equalTo: view.superview!.topAnchor)
    }
  }

  public init(equalTo target: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { view in generateEqualConstraint(for: view, \.topAnchor, \.topAnchor, to: target()) }
  }

  public init(equalTo target: @autoclosure @escaping () -> VerticalConstraint, @ConstraintModifierBuilder _ modifier: () -> ConstraintModifier) {
    constraint = { view in generateEqualConstraint(for: view, \.topAnchor, \.topAnchor, to: target()) }
  }


  public init(greaterThan target: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {
    constraint = { view in generateGreaterConstraint(for: view, \.topAnchor, \.topAnchor, to: target()) }
  }

  public init(greaterThan target: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { view in generateGreaterConstraint(for: view, \.topAnchor, \.topAnchor, to: target()) }
  }


  public init(lessThan target: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {
    constraint = { view in generateLesserConstraint(for: view, \.topAnchor, \.topAnchor, to: target()) }
  }

  public init(lessThan target: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { view in generateLesserConstraint(for: view, \.topAnchor, \.topAnchor, to: target()) }
  }
}
