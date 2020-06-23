//
//  Inset.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

extension UIEdgeInsets: ConstraintModifier {

  public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target: Constraint {

    switch target {
    case is Leading.Type:
      constraint.constant = left
    case is Trailing.Type:
      constraint.constant = -right
    case is Top.Type:
      constraint.constant = top
    case is Bottom.Type:
      constraint.constant = -bottom
    case is CenterX.Type:
      constraint.constant = left
    case is CenterY.Type:
      constraint.constant = top
    default:
      break // do nothing
    }
  }
}
