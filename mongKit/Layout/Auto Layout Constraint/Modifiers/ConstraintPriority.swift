//
//  ConstraintPriority.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public enum ConstraintPriority: CGFloat, ConstraintModifier {
  case yield = 1
  case low = 250
  case medium = 750
  case high = 999
  case required = 1000

  public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target: Constraint {
    constraint.priority = .init(Float(rawValue))
  }
}
