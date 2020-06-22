//
//  Constraint.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol Constraint {
  var constraint: (UIView) -> [NSLayoutConstraint] { get }
}


public protocol HorizontalConstraint {
}

public protocol HorizontalConstraintConstructible {

  init()
  init(equalTo: @autoclosure @escaping () -> HorizontalConstraint)
  init(equalTo: @autoclosure @escaping () -> HorizontalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier)

  init(greaterThan: @autoclosure @escaping () -> HorizontalConstraint)
  init(greaterThan: @autoclosure @escaping () -> HorizontalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier)

  init(lessThan: @autoclosure @escaping () -> HorizontalConstraint)
  init(lessThan: @autoclosure @escaping () -> HorizontalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier)
}

public protocol VerticalConstraint {
}

public protocol VerticalConstraintConstructible {

  init()
  init(equalTo: @autoclosure @escaping () -> VerticalConstraint)
  init(equalTo: @autoclosure @escaping () -> VerticalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier)

  init(greaterThan: @autoclosure @escaping () -> VerticalConstraint)
  init(greaterThan: @autoclosure @escaping () -> VerticalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier)

  init(lessThan: @autoclosure @escaping () -> VerticalConstraint)
  init(lessThan: @autoclosure @escaping () -> VerticalConstraint, @ConstraintModifierBuilder _ builder: () -> ConstraintModifier)
}


extension NSLayoutXAxisAnchor: HorizontalConstraint {
}

extension NSLayoutYAxisAnchor: VerticalConstraint {
}

extension UIView: HorizontalConstraint, VerticalConstraint {
}

extension UILayoutGuide: HorizontalConstraint, VerticalConstraint {
}

public protocol SizeConstraint {

}

extension NSLayoutDimension: SizeConstraint {
}
