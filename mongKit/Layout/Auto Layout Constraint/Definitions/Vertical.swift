//
//  Vertical.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Vertical: Constraint {

  public let constraint: (UIView) -> [NSLayoutConstraint]

  public init() {
    constraint = { target in
      [ target.topAnchor      .constraint(equalTo: target.superview!.topAnchor      ) ,
        target.bottomAnchor   .constraint(equalTo: target.superview!.bottomAnchor   ) ]
    }
  }

  public init(@ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      [ tell(target.topAnchor     .constraint(equalTo: target.superview!.topAnchor     )) {
          modifier.apply(target: Top.self , $0) } ,
        tell(target.bottomAnchor  .constraint(equalTo: target.superview!.bottomAnchor  )) {
          modifier.apply(target: Bottom.self, $0) } ]
    }
  }

  public init(_ view: @escaping @autoclosure () -> UIView) {
    constraint = { target in
      let view = view()
      return [
        target.topAnchor      .constraint(equalTo: view.topAnchor      ) ,
        target.bottomAnchor   .constraint(equalTo: view.bottomAnchor   ) ]
    }
  }

  public init(_ view: @escaping @autoclosure () -> UIView, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      let view = view()
      return [
        tell(target.topAnchor     .constraint(equalTo: view.topAnchor     )) {
          modifier.apply(target: Top.self , $0) } ,
        tell(target.bottomAnchor  .constraint(equalTo: view.bottomAnchor  )) {
          modifier.apply(target: Bottom.self, $0) } ]
    }
  }

  public init(_ view: @escaping @autoclosure () -> UILayoutGuide) {
    constraint = { target in
      let view = view()
      return [
        target.topAnchor      .constraint(equalTo: view.topAnchor      ) ,
        target.bottomAnchor   .constraint(equalTo: view.bottomAnchor   ) ]
    }
  }

  public init(_ view: @escaping @autoclosure () -> UILayoutGuide, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    let modifier = builder()
    constraint = { target in
      let view = view()
      return [
        tell(target.topAnchor     .constraint(equalTo: view.topAnchor     )) {
          modifier.apply(target: Top.self , $0) } ,
        tell(target.bottomAnchor  .constraint(equalTo: view.bottomAnchor  )) {
          modifier.apply(target: Bottom.self, $0) } ]
    }
  }
}
