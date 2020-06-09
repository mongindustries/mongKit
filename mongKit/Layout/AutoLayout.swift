//
//  AutoLayoutConfiguration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol Constraint {
  var constraint: () -> NSLayoutConstraint { get }
}

public struct Raw: Constraint {

  public let constraint: () -> NSLayoutConstraint

  public init(_ raw: @escaping () -> NSLayoutConstraint) {
    constraint = raw
  }
}


@_functionBuilder
public struct AutoLayoutBuilder {
  public static func buildBlock(_ children: Constraint) -> AutoLayoutConfiguration {
    return .init(constraints: [ children.constraint ])
  }
  public static func buildBlock(_ children: Constraint...) -> AutoLayoutConfiguration {
    return .init(constraints: children.map{ $0.constraint })
  }
}

public struct AutoLayoutConfiguration {
  let constraints: [() -> NSLayoutConstraint]
}

public class AutoLayout: Layout {

  let constraints: [() -> NSLayoutConstraint]

  public init(@AutoLayoutBuilder _ builder: () -> AutoLayoutConfiguration) {
    constraints = builder().constraints
  }

  public override func apply(_ target: UIView) {

    target.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate(constraints.map({ $0() }))
  }
}
