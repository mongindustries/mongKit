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

  public init(_ view: UIView) {
    constraint = { target in
    [ target.topAnchor      .constraint(equalTo: view.topAnchor      ) ,
      target.bottomAnchor   .constraint(equalTo: view.bottomAnchor   ) ]
    }
  }
}
