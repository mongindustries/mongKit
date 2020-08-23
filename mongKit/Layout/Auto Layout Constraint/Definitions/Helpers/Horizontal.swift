//
//  Horizontal.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Horizontal: Constraint {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init(@ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.leadingAnchor  .constraint(equalTo: target.superview!.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: target.superview!.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ]
    }
  }

  public init(_ view                                : @escaping @autoclosure () -> UIView,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { target in
      let view = view()
      return [
        tell(target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: view.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ]
    }
  }

  public init(_ view                                : @escaping @autoclosure () -> UILayoutGuide,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let modifier = builder()
    constraint = { target in
      let view = view()
      return [
        tell(target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: view.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ]
    }
  }
}
