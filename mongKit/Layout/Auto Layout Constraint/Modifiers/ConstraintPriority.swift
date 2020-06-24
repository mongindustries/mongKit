//
//  ConstraintPriority.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

extension UILayoutPriority: ConstraintModifier {
  public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target : Constraint {
    constraint.priority = self
  }
}
