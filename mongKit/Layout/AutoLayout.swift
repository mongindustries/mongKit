//
//  AutoLayoutConfiguration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

@_functionBuilder
public struct AutoLayoutBuilder: Constraint {

  public static func buildBlock(_ children: Constraint...) -> AutoLayoutBuilder {
    .init(constraints: children.map { $0.constraint })
  }


  public let constraint: (UIView) -> [NSLayoutConstraint]

  init(constraints: [(UIView) -> [NSLayoutConstraint]]) {
    constraint = { view in

      view.translatesAutoresizingMaskIntoConstraints = false
      return constraints.flatMap { $0(view) }
    }
  }
}


public class AutoLayout: Layout {

  let constraints: AutoLayoutBuilder

  public init(@AutoLayoutBuilder _ builder: () -> Constraint) {
    constraints = builder() as! AutoLayoutBuilder
  }

  public override func apply(_ target: UIView) {
    NSLayoutConstraint.activate(constraints.constraint(target))
  }
}
