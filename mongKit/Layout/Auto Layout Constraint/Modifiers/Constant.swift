//
//  Constant.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Constant: ConstraintModifier {

  let value: CGFloat

  public init(_ value: CGFloat) {
    self.value = value
  }

  public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target: Constraint {
    constraint.constant = value
  }
}
