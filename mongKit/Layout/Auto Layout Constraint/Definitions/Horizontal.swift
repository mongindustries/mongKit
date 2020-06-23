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

  public init() {
    constraint = { target in
      [ target.leadingAnchor  .constraint(equalTo: target.superview!.leadingAnchor  ) ,
        target.trailingAnchor .constraint(equalTo: target.superview!.trailingAnchor ) ]
    }
  }

  public init(@ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.leadingAnchor  .constraint(equalTo: target.superview!.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: target.superview!.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ]
    }
  }

  public init(_ view: UIView) {
    constraint = { target in
    [ target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  ) ,
      target.trailingAnchor .constraint(equalTo: view.trailingAnchor ) ]
    }
  }

  public init(_ view: UIView, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: view.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ]
    }
  }

  public init(_ view: UILayoutGuide) {
    constraint = { target in
    [ target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  ) ,
      target.trailingAnchor .constraint(equalTo: view.trailingAnchor ) ]
    }
  }

  public init(_ view: UILayoutGuide, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: view.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ]
    }
  }
}
