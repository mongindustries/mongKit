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

  public init() {
    constraint = { target in
      [ target.centerXAnchor.constraint(equalTo: target.superview!.centerXAnchor) ,
        target.centerYAnchor.constraint(equalTo: target.superview!.centerYAnchor) ]
    }
  }

  public init(_ view: UIView) {
    constraint = { target in
      [ target.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
        target.centerYAnchor.constraint(equalTo: view.centerYAnchor) ]
    }
  }
}
