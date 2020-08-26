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
    AutoLayoutBuilder(constraints: children.compactMap { $0.constraint })
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  init(constraints: [(Weak<UIView>) -> [NSLayoutConstraint]]) {
    constraint = { view in
      view.wrappedValue!.translatesAutoresizingMaskIntoConstraints = false
      return constraints.flatMap { $0(view) }
    }
  }
}


public struct AutoLayout: LayoutConfiguration {

  let constraints: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@AutoLayoutBuilder _ builder: () -> Constraint) {

    let x = builder()

    if let bbuilder = x as? AutoLayoutBuilder {
      constraints = bbuilder.constraint
    } else {
      constraints = x.constraint
    }
  }

  public func apply(_ target: UIView) {
    NSLayoutConstraint.activate(constraints(Weak(wrappedValue: target)))
  }
}

extension UIView {
  
  public func buildConstraints(@AutoLayoutBuilder _ builder: () -> Constraint) {
    AutoLayout(builder).apply(self)
  }
}
