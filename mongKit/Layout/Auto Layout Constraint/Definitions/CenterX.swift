//
//  CenterX.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public class CenterX: Constraint, HorizontalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public required init() {
    constraint = { target in
      [ target.centerXAnchor.constraint(equalTo: target.superview!.centerXAnchor) ]
    }
  }

  public required init(equalTo anchor: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { target in
      [ generateEqualConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor()) ]
    }
  }

  public required init(equalTo anchor: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateEqualConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor())) {
        modifiers.apply(target: CenterX.self, $0) } ]
    }
  }

  public required init(greaterThan anchor: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { target in
      [ generateGreaterConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor()) ]
    }
  }

  public required init(greaterThan anchor: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateGreaterConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor())) {
        modifiers.apply(target: CenterX.self, $0) } ]
    }
  }

  public required init(lessThan anchor: @autoclosure @escaping () -> HorizontalConstraint) {
    constraint = { target in
      [ generateLesserConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor()) ]
    }
  }

  public required init(lessThan anchor: @autoclosure @escaping () -> HorizontalConstraint, _ builder: () -> ConstraintModifier) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateLesserConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor())) {
        modifiers.apply(target: CenterX.self, $0) } ]
    }
  }
}
