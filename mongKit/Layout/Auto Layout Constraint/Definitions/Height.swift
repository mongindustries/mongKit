//
//  Height.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public struct Height: Constraint {
  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(_ value: CGFloat) {
    constraint = { target in
      [ target.heightAnchor.constraint(equalToConstant: value) ]
    }
  }


  public init(_ view: @escaping @autoclosure () -> UIView, _ dimension: NSLayoutConstraint.Axis = .vertical) {
    constraint = { target in

      let view = view()

      return [
        target.heightAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor) ]
    }
  }

  public init(_ view: @escaping @autoclosure () -> UIView, _ dimension: NSLayoutConstraint.Axis = .vertical, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in

      let view = view()

      return [
        tell(target.heightAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor))
          { modifier.apply(target: Height.self, $0) } ]
    }
  }


  public init(_ view: @escaping @autoclosure () -> UILayoutGuide, _ dimension: NSLayoutConstraint.Axis = .vertical) {
    constraint = { target in

      let view = view()

      return [
        target.heightAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor) ]
    }
  }

  public init(_ view: @escaping @autoclosure () -> UILayoutGuide, _ dimension: NSLayoutConstraint.Axis = .vertical, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in

      let view = view()

      return [
        tell(target.heightAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor))
          { modifier.apply(target: Height.self, $0) } ]
    }
  }
}
