//
//  ConstraintModifier.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

public protocol ConstraintModifier {
  func apply(target: Constraint.Type, _ constraint: NSLayoutConstraint)
}

public struct CompositeConstraintModifier: ConstraintModifier {

  let constraints: [ConstraintModifier]

  init(_ constraints: [ConstraintModifier]) {
    self.constraints = constraints
  }

  public func apply(target: Constraint.Type, _ constraint: NSLayoutConstraint) {
    constraints.forEach{ $0.apply(target: target, constraint) }
  }
}

@_functionBuilder
public struct ConstraintModifierBuilder {

  public static func buildBlock(_ builder: ConstraintModifier...) -> ConstraintModifier {
    CompositeConstraintModifier(builder)
  }
}

public struct EmptyConstraintModifier: ConstraintModifier {

  public init() { }

  public func apply(target: Constraint.Type, _ constraint: NSLayoutConstraint) { }
}
