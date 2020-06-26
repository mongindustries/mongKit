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

  public static func buildBlock<C: Constraint>(_ children: C) -> Constraint {
    AutoLayoutBuilder(constraints: [ children.constraint ])
  }

  public static func buildBlock(_ children: Constraint...) -> Constraint {
    AutoLayoutBuilder(constraints: children.map { $0.constraint })
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

    let x = builder()

    if let bbuilder = x as? AutoLayoutBuilder {
      constraints = bbuilder
    } else {
      constraints = .init(constraints: [ x.constraint ])
    }
  }

  public override func apply(_ target: UIView) {
    NSLayoutConstraint.activate(constraints.constraint(target))
  }
}
