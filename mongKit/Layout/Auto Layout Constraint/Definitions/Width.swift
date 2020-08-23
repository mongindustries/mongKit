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

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.widthAnchor.constraint(equalTo: target.superview!.widthAnchor)) {
        modifier.apply(target: Width.self, $0) } ]
    }
  }
  
  public init(_ value                               : CGFloat,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.widthAnchor.constraint(equalToConstant: value)) {
        modifier.apply(target: Width.self, $0) } ]
    }
  }

  public init(_ view                                : @escaping @autoclosure () -> UIView,
              _ dimension                           : NSLayoutConstraint.Axis = .horizontal,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()
    constraint = { target in

      let view = view()

      return [
        tell(target.widthAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor, multiplier: multiplier))
          { modifier.apply(target: Width.self, $0) } ]
    }
  }

  public init(_ view                                : @escaping @autoclosure () -> UILayoutGuide,
              _ dimension                           : NSLayoutConstraint.Axis = .horizontal,
              multiplier                            : CGFloat = 1,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()
    constraint = { target in

      let view = view()

      return [
        tell(target.widthAnchor.constraint(equalTo: dimension == .horizontal ? view.widthAnchor : view.heightAnchor, multiplier: multiplier))
          { modifier.apply(target: Width.self, $0) } ]
    }
  }
}
