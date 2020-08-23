//
//  ConstraintGroup.swift
//  mongKit
//
//  Created by Michael Ong on 8/24/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct ConstraintGroup: Constraint {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(_ items                               : [Constraint],
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      items.map { (item: Constraint) in
        (item.constraint(target), type(of: item))
      }.flatMap { constraint, type -> [NSLayoutConstraint] in
        constraint.map { item -> NSLayoutConstraint in
          modifier.apply(target: type, item)
          return item
        }
      }
    }
  }
}
