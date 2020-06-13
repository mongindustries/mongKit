//
//  Leading.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Leading: Constraint, HorizontalConstraintConstructible {

  public let constraint: (UIView) -> NSLayoutConstraint

  public init() {
    constraint = { view in
      return view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor)
    }
  }

  public init(equalTo target: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { view in generateEqualConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target()) }
  }

  public init(equalTo target: @autoclosure @escaping () -> HorizontalConstraint, @ConstraintModifierBuilder _ modifier: () -> ConstraintModifier) {
    constraint = { view in generateEqualConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target()) }
  }


  public init(greaterThan target: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {
    constraint = { view in generateGreaterConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target()) }
  }

  public init(greaterThan target: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { view in generateGreaterConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target()) }
  }


  public init(lessThan target: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {
    constraint = { view in generateLesserConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target()) }
  }

  public init(lessThan target: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { view in generateLesserConstraint(for: view, \.leadingAnchor, \.leadingAnchor, to: target()) }
  }
}
