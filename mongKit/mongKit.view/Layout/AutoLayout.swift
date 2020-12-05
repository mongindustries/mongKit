//
//  AutoLayoutConfiguration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

@_functionBuilder
public struct AutoLayoutBuilder: Constraint {

  public static func buildBlock(_ children: Constraint...) -> Constraint {
    AutoLayoutBuilder(constraints: children.map { $0.constraint })
  }


  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  init(constraints: [(Weak<UIView>) -> [NSLayoutConstraint]]) {
    constraint = { view in constraints.flatMap { $0(view) } }
  }
}

public class AutoLayout: LayoutConfiguration {

  let constraints: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(@AutoLayoutBuilder _ builder: () -> Constraint) {
    constraints = builder().constraint
  }

  public func apply(_ target: UIView) {
    target.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(constraints(Weak(wrappedValue: target)))
  }
}

extension UIView {
  
  public func buildConstraints(@AutoLayoutBuilder _ builder: () -> Constraint) {
    AutoLayout(builder).apply(self)
  }
}
