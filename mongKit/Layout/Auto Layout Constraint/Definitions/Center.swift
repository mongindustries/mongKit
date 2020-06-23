//
//  Center.swift
//  mongKit
//
//  Created by Michael Ong on 18/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Center: Constraint {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init() {
    constraint = { target in
      [ target.centerXAnchor.constraint(equalTo: target.superview!.centerXAnchor) ,
        target.centerYAnchor.constraint(equalTo: target.superview!.centerYAnchor) ]
    }
  }

  public init(@ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()

    constraint = { target in
      [ tell(target.centerXAnchor.constraint(equalTo: target.superview!.centerXAnchor)) {
          modifier.apply(target: CenterX.self, $0) } ,
        tell(target.centerYAnchor.constraint(equalTo: target.superview!.centerYAnchor)) {
          modifier.apply(target: CenterY.self, $0) } ]
    }
  }

  public init(_ view: UIView) {
    constraint = { target in
      [ target.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
        target.centerYAnchor.constraint(equalTo: view.centerYAnchor) ]
    }
  }

  public init(_ view: UIView, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()

    constraint = { target in
      [ tell(target.centerXAnchor.constraint(equalTo: view.centerXAnchor)) {
          modifier.apply(target: CenterX.self, $0) } ,
        tell(target.centerYAnchor.constraint(equalTo: view.centerYAnchor)) {
          modifier.apply(target: CenterY.self, $0) } ]
    }
  }
}
