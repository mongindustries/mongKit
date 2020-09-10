//
//  ConstraintPriority.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

extension UILayoutPriority: ConstraintModifier {
  public func apply(target: Constraint.Type, _ constraint: NSLayoutConstraint) {
    constraint.priority = self
  }
}
