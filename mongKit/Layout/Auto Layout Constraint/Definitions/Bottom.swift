//
//  Bottom.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Bottom: Constraint, VerticalConstraintConstructible {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init() {
    constraint = { view in
      return [view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor)]
    }
  }


  public init(equalTo target: @autoclosure @escaping () -> VerticalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { view in [
      tell(generateEqualConstraint(for: view, \.bottomAnchor, \.bottomAnchor, to: target())) {
        modifier.apply(target: Bottom.self, $0)
      }] }
  }

  public init(equalTo target: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { view in [generateEqualConstraint(for: view, \.bottomAnchor, \.bottomAnchor, to: target())] }
  }


  public init(greaterThan target: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { view in [
      tell(generateGreaterConstraint(for: view, \.bottomAnchor, \.bottomAnchor, to: target())) {
        modifier.apply(target: Bottom.self, $0)
      }] }
  }

  public init(greaterThan target: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { view in [generateGreaterConstraint(for: view, \.bottomAnchor, \.bottomAnchor, to: target())] }
  }


  public init(lessThan target: @autoclosure @escaping () -> VerticalConstraint, _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { view in [
      tell(generateLesserConstraint(for: view, \.bottomAnchor, \.bottomAnchor, to: target())) {
        modifier.apply(target: Bottom.self, $0)
      }] }
  }

  public init(lessThan target: @autoclosure @escaping () -> VerticalConstraint) {
    constraint = { view in [generateLesserConstraint(for: view, \.bottomAnchor, \.bottomAnchor, to: target())] }
  }
}
