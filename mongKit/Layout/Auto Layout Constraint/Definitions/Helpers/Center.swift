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

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.centerXAnchor.constraint(equalTo: target.superview!.centerXAnchor)) {
          modifier.apply(target: CenterX.self, $0) } ,
        tell(target.centerYAnchor.constraint(equalTo: target.superview!.centerYAnchor)) {
          modifier.apply(target: CenterY.self, $0) } ]
    }
  }

  public init(_ view                                : @autoclosure @escaping () -> UIView,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in

      let view = view()

      return [
        tell(target.centerXAnchor.constraint(equalTo: view.centerXAnchor)) {
          modifier.apply(target: CenterX.self, $0) } ,
        tell(target.centerYAnchor.constraint(equalTo: view.centerYAnchor)) {
          modifier.apply(target: CenterY.self, $0) } ]
    }
  }

  public init(_ view                                : @autoclosure @escaping () -> UILayoutGuide,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = { target in

      let view = view()

      return [
        tell(target.centerXAnchor.constraint(equalTo: view.centerXAnchor)) {
          modifier.apply(target: CenterX.self, $0) } ,
        tell(target.centerYAnchor.constraint(equalTo: view.centerYAnchor)) {
          modifier.apply(target: CenterY.self, $0) } ]
    }
  }
}