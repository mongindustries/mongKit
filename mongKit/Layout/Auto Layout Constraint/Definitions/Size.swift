//
//  Size.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Size: Constraint {
  public var constraint: (UIView) -> [NSLayoutConstraint]

  public init(_ value: CGFloat) {
    constraint = {
      [ $0.widthAnchor  .constraint(equalToConstant: value) ,
        $0.heightAnchor .constraint(equalToConstant: value) ]
    }
  }

  public init(_ size: CGSize) {
    constraint = {
      [ $0.widthAnchor  .constraint(equalToConstant: size.width ) ,
        $0.heightAnchor .constraint(equalToConstant: size.height) ]
    }
  }

  public init(_ view: UIView) {
    constraint = {
      [ $0.widthAnchor  .constraint(equalTo: view.widthAnchor   ) ,
        $0.heightAnchor .constraint(equalTo: view.heightAnchor  ) ]
    }
  }

  public init(_ view: UIView, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier) {
    constraint = {
      [ $0.widthAnchor  .constraint(equalTo: view.widthAnchor   ) ,
        $0.heightAnchor .constraint(equalTo: view.heightAnchor  ) ]
    }
  }
}
