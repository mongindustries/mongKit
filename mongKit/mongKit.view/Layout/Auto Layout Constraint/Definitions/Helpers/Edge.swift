//
//  Edge.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
import mongKitCore

public struct Edge: Constraint {
  
  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    constraint = { target in

      guard let view: UIView = target.wrappedValue?.superview else { fatalError() }

      return
        Leading   .equalTo(view, constraint: \UIView.leadingAnchor  , builder).constraint(target) +
        Trailing  .equalTo(view, constraint: \UIView.trailingAnchor , builder).constraint(target) +
        Top       .equalTo(view, constraint: \UIView.topAnchor      , builder).constraint(target) +
        Bottom    .equalTo(view, constraint: \UIView.bottomAnchor   , builder).constraint(target)
    }
  }

  public init<Target: UIView>(
    _ target                              : Target,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let weak = Weak(wrappedValue: target)
    constraint = { target in

      guard let view = weak.wrappedValue else { fatalError() }

      return
        Leading   .equalTo(view, constraint: \UIView.leadingAnchor  , builder).constraint(target) +
        Trailing  .equalTo(view, constraint: \UIView.trailingAnchor , builder).constraint(target) +
        Top       .equalTo(view, constraint: \UIView.topAnchor      , builder).constraint(target) +
        Bottom    .equalTo(view, constraint: \UIView.bottomAnchor   , builder).constraint(target)
    }
  }
  
  public init<Target: UILayoutGuide>(
    _ target                              : Target,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    let weak = Weak(wrappedValue: target)
    constraint = { target in

      guard let view = weak.wrappedValue else { fatalError() }

      return
        Leading   .equalTo(view, constraint: \UILayoutGuide.leadingAnchor  , builder).constraint(target) +
        Trailing  .equalTo(view, constraint: \UILayoutGuide.trailingAnchor , builder).constraint(target) +
        Top       .equalTo(view, constraint: \UILayoutGuide.topAnchor      , builder).constraint(target) +
        Bottom    .equalTo(view, constraint: \UILayoutGuide.bottomAnchor   , builder).constraint(target)
    }
  }
}
