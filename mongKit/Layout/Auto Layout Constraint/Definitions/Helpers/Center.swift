//
//  Center.swift
//  mongKit
//
//  Created by Michael Ong on 18/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Center: Constraint {

  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    constraint = { target in

      guard let view: UIView = target.wrappedValue?.superview else { fatalError() }

      return
        CenterX.equalTo(view, constraint: \UIView.centerXAnchor, builder).constraint(target) +
        CenterY.equalTo(view, constraint: \UIView.centerYAnchor, builder).constraint(target)
    }
  }
  
  public init<Target: UIView>(
    _ target                              : Target,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let weak = Weak(wrappedValue: target)
    constraint = { target in

      guard let view = weak.wrappedValue else { fatalError() }

      return
        CenterX.equalTo(view, constraint: \UIView.centerXAnchor, builder).constraint(target) +
        CenterY.equalTo(view, constraint: \UIView.centerYAnchor, builder).constraint(target)
    }
  }
  
  public init<Target: UILayoutGuide>(
    _ target                              : Target,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let weak = Weak(wrappedValue: target)
    constraint = { target in

      guard let view = weak.wrappedValue else { fatalError() }

      return
        CenterX.equalTo(view, constraint: \UILayoutGuide.centerXAnchor, builder).constraint(target) +
        CenterY.equalTo(view, constraint: \UILayoutGuide.centerYAnchor, builder).constraint(target)
    }
  }
}
