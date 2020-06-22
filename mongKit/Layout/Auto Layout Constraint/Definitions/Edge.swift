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

  public init(_ view: UIView) {
    constraint = { target in
    [ target.leadingAnchor  .constraint(equalTo: view.leadingAnchor  ) ,
      target.trailingAnchor .constraint(equalTo: view.trailingAnchor ) ,
      target.topAnchor      .constraint(equalTo: view.topAnchor      ) ,
      target.bottomAnchor   .constraint(equalTo: view.bottomAnchor   ) ]
    }
  }
}
