//
//  ConstraintModifier.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol ConstraintModifier {
}

public struct CompositeConstraintModifier: ConstraintModifier {
}

public struct EmptyConstraintModifier: ConstraintModifier {
}


@_functionBuilder
public struct ConstraintModifierBuilder {

  public static func buildBlock(_ builder: ConstraintModifier...) -> ConstraintModifier {
    CompositeConstraintModifier()
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
}

public enum ConstraintPriority: CGFloat, ConstraintModifier {
  case yield = 1
  case low = 250
  case medium = 750
  case high = 999
  case required = 1000
}
