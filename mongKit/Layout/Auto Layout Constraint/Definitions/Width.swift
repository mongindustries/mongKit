//
//  Width.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public struct Width: Constraint {
  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(_ value: CGFloat) {
    constraint = { target in
      [ target.widthAnchor.constraint(equalToConstant: value) ]
    }
  }


  public init(_ view: UIView, _ dimension: NSLayoutConstraint.Axis = .horizontal) {
    constraint = { target in
      [ target.widthAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor) ]
    }
  }

  public init(_ view: UIView, _ dimension: NSLayoutConstraint.Axis, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.widthAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor))
          { modifier.apply(target: Width.self, $0) } ]
    }
  }


  public init(_ view: UILayoutGuide, _ dimension: NSLayoutConstraint.Axis = .horizontal) {
    constraint = { target in
      [ target.widthAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor) ]
    }
  }

  public init(_ view: UILayoutGuide, _ dimension: NSLayoutConstraint.Axis = .horizontal, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.widthAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor))
          { modifier.apply(target: Width.self, $0) } ]
    }
  }
}
