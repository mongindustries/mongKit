//
//  ConstraintModifier.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol ConstraintModifier {
  func apply(_ target: NSLayoutConstraint)
}

public struct CompositeConstraintModifier: ConstraintModifier {

  let constraints: [ConstraintModifier]

  init(_ constraints: [ConstraintModifier]) {
    self.constraints = constraints
  }

  public func apply(_ target: NSLayoutConstraint) {
    constraints.forEach{ $0.apply(target) }
  }
}

@_functionBuilder
public struct ConstraintModifierBuilder {

  public static func buildBlock(_ builder: ConstraintModifier...) -> ConstraintModifier {
    CompositeConstraintModifier(builder)
  }
}


public struct Inset: ConstraintModifier {
  public init(_ all: CGFloat) {
  }

  public init(left: CGFloat, top: CGFloat, rigt: CGFloat, bottom: CGFloat) {
  }

  public init(horizontal: CGFloat, vertical: CGFloat) {
  }

  public init(top: CGFloat, sides: CGFloat, bottom: CGFloat) {
  }

  public func apply(_ target: NSLayoutConstraint) {
  }
}

public enum ConstraintPriority: CGFloat, ConstraintModifier {
  case yield = 1
  case low = 250
  case medium = 750
  case high = 999
  case required = 1000

  public func apply(_ target: NSLayoutConstraint) {
    target.priority = .init(Float(rawValue))
  }
}
