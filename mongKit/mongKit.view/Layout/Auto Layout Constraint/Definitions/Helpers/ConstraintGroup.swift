//
//  ConstraintGroup.swift
//  mongKit
//
//  Created by Michael Ong on 8/24/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
import mongKitCore

public struct ConstraintGroup: Constraint {

  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(_ items                               : [Constraint],
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      items
        .map      { ($0.constraint(target), type(of: $0)) }
        .flatMap  { constraint, type -> [NSLayoutConstraint] in
          constraint.map { item -> NSLayoutConstraint in
            modifier.apply(target: type, item)
            return item
          }
        }
    }
  }
}
