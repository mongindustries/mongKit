//
//  Inset.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Inset: ConstraintModifier {

  let insets : UIEdgeInsets

  public init(_ all: CGFloat) {
    insets = .init(top: all, left: all, bottom: all, right: all)
  }

  public init(left: CGFloat, top: CGFloat, rigt: CGFloat, bottom: CGFloat) {
    insets = .init(top: top, left: left, bottom: bottom, right: rigt)
  }

  public init(horizontal: CGFloat, vertical: CGFloat) {
    insets = .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }

  public init(top: CGFloat, sides: CGFloat, bottom: CGFloat) {
    insets = .init(top: top, left: sides, bottom: bottom, right: sides)
  }

  public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target: Constraint {

    switch target {
    case is Leading.Type:
      constraint.constant = insets.left
    case is Trailing.Type:
      constraint.constant = -insets.right
    case is Top.Type:
      constraint.constant = insets.top
    case is Bottom.Type:
      constraint.constant = -insets.bottom
    case is CenterX.Type:
      constraint.constant = insets.left
    case is CenterY.Type:
      constraint.constant = insets.top
    default:
      break // do nothing
    }
  }
}
