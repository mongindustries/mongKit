//
//  ConstraintModifier.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol ConstraintModifier {
  func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target: Constraint
}

public struct CompositeConstraintModifier: ConstraintModifier {

  let constraints: [ConstraintModifier]

  init(_ constraints: [ConstraintModifier]) {
    self.constraints = constraints
  }

  public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target: Constraint {
    constraints.forEach{ $0.apply(target: target, constraint) }
  }
}

@_functionBuilder
public struct ConstraintModifierBuilder {

  public static func buildBlock(_ builder: ConstraintModifier...) -> ConstraintModifier {
    CompositeConstraintModifier(builder)
  }
}
