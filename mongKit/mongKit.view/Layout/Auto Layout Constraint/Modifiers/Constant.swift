//
//  Constant.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Constant: ConstraintModifier {
  
  let value: CGFloat

  public init(_ value: CGFloat) {
    self.value = value
  }

  public func apply(target: Constraint.Type, _ constraint: NSLayoutConstraint) {
    constraint.constant = value
  }
}
