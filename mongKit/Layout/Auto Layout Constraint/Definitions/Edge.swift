//
//  Edge.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Edge: Constraint {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init() {
    constraint = { target in
      [ target.leadingAnchor  .constraint(equalTo: target.superview!.leadingAnchor  ) ,
        target.trailingAnchor .constraint(equalTo: target.superview!.trailingAnchor ) ,
        target.topAnchor      .constraint(equalTo: target.superview!.topAnchor      ) ,
        target.bottomAnchor   .constraint(equalTo: target.superview!.bottomAnchor   ) ]
    }
  }

  public init(@ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.leadingAnchor  .constraint(equalTo: target.superview!.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: target.superview!.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ,
        tell(target.topAnchor      .constraint(equalTo: target.superview!.topAnchor      )) {
          modifier.apply(target: Top.self, $0) } ,
        tell(target.bottomAnchor   .constraint(equalTo: target.superview!.bottomAnchor   )) {
          modifier.apply(target: Bottom.self, $0) } ]
    }
  }

  public init(_ view: UIView) {
    constraint = { target in
      [ target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  ) ,
        target.trailingAnchor .constraint(equalTo: view.trailingAnchor ) ,
        target.topAnchor      .constraint(equalTo: view.topAnchor      ) ,
        target.bottomAnchor   .constraint(equalTo: view.bottomAnchor   ) ]
    }
  }

  public init(_ view: UIView, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {

    let modifier = builder()

    constraint = { target in
      [ tell(target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  )) {
          modifier.apply(target: Leading.self , $0) } ,
        tell(target.trailingAnchor .constraint(equalTo: view.trailingAnchor )) {
          modifier.apply(target: Trailing.self, $0) } ,
        tell(target.topAnchor      .constraint(equalTo: view.topAnchor      )) {
          modifier.apply(target: Top.self, $0) } ,
        tell(target.bottomAnchor   .constraint(equalTo: view.bottomAnchor   )) {
          modifier.apply(target: Bottom.self, $0) } ]
    }
  }
}
