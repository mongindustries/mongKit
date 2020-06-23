//
//  CenterY.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public class CenterY: Constraint, VerticalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public required init() {
    constraint = { target in
      [ target.centerYAnchor.constraint(equalTo: target.superview!.centerYAnchor) ]
    }
  }

  public required init(equalTo anchor: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { target in
      [ generateEqualConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor()) ]
    }
  }

  public required init(equalTo anchor: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateEqualConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor())) {
        modifiers.apply(target: CenterY.self, $0) } ]
    }
  }

  public required init(greaterThan anchor: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { target in
      [ generateGreaterConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor()) ]
    }
  }

  public required init(greaterThan anchor: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateGreaterConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor())) {
        modifiers.apply(target: CenterY.self, $0) } ]
    }
  }

  public required init(lessThan anchor: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { target in
      [ generateLesserConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor()) ]
    }
  }

  public required init(lessThan anchor: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {

    let modifiers = builder()

    constraint = { target in
      [ tell(generateLesserConstraint(for: target, \.centerYAnchor, \.centerYAnchor, to: anchor())) {
        modifiers.apply(target: CenterY.self, $0) } ]
    }
  }
}
