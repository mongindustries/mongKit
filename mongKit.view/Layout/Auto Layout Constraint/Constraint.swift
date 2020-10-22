//
//  Constraint.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
import mongKitCore

public protocol Constraint {
  var constraint: (Weak<UIView>) -> [NSLayoutConstraint] { get }
}

public protocol HorizontalConstraint {
}

public protocol HorizontalConstraintConstructible {

  static func equalTo<Target: NSObject, TConstraint: HorizontalConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint

  static func lessThan<Target: NSObject, TConstraint: HorizontalConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint

  static func moreThan<Target: NSObject, TConstraint: HorizontalConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint


  init(@ConstraintModifierBuilder _ builder : () -> ConstraintModifier)

  
  @available(*, deprecated, message: "Do not use. Use other methods instead.")
  init(equalTo                              : @autoclosure @escaping () -> HorizontalConstraint,
       @ConstraintModifierBuilder _ builder : () -> ConstraintModifier)

  @available(*, deprecated, message: "Do not use. Use other methods instead.")
  init(greaterThan                          : @autoclosure @escaping () -> HorizontalConstraint,
       multiplier                           : CGFloat,
       @ConstraintModifierBuilder _ builder : () -> ConstraintModifier)

  @available(*, deprecated, message: "Do not use. Use other methods instead.")
  init(lessThan                             : @autoclosure @escaping () -> HorizontalConstraint,
       multiplier                           : CGFloat,
       @ConstraintModifierBuilder _ builder : () -> ConstraintModifier)
}

public protocol VerticalConstraint {
}

public protocol VerticalConstraintConstructible {

  static func equalTo<Target: NSObject, TConstraint: VerticalConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint

  static func lessThan<Target: NSObject, TConstraint: VerticalConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint

  static func moreThan<Target: NSObject, TConstraint: VerticalConstraint>(
    _ target                              : Target,
    constraint                            : KeyPath<Target, TConstraint>,
    @ConstraintModifierBuilder _ builder  : @escaping () -> ConstraintModifier) -> Constraint


  init(@ConstraintModifierBuilder _ builder : () -> ConstraintModifier)


  @available(*, deprecated, message: "Do not use. Use other methods instead.")
  init(equalTo                              : @autoclosure @escaping () -> VerticalConstraint,
       @ConstraintModifierBuilder _ builder : () -> ConstraintModifier)

  @available(*, deprecated, message: "Do not use. Use other methods instead.")
  init(greaterThan                          : @autoclosure @escaping () -> VerticalConstraint,
       multiplier                           : CGFloat,
       @ConstraintModifierBuilder _ builder : () -> ConstraintModifier)

  @available(*, deprecated, message: "Do not use. Use other methods instead.")
  init(lessThan                             : @autoclosure @escaping () -> VerticalConstraint,
       multiplier                           : CGFloat,
       @ConstraintModifierBuilder _ builder : () -> ConstraintModifier)
}


extension NSLayoutXAxisAnchor: HorizontalConstraint {
}

extension NSLayoutYAxisAnchor: VerticalConstraint {
}


extension UIView        : HorizontalConstraint, VerticalConstraint {
}

extension UILayoutGuide : HorizontalConstraint, VerticalConstraint {
}


public protocol SizeConstraint {

}

extension NSLayoutDimension: SizeConstraint {
}

func convertHorizontalConstraint(
  _ horizontalConstraint  : HorizontalConstraint,
  viewSelector            : KeyPath<UIView, NSLayoutXAxisAnchor>,
  guideSelector           : KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>) -> NSLayoutXAxisAnchor {

  switch horizontalConstraint {
  case let view as UIView:
    return view[keyPath: viewSelector]
  case let view as UILayoutGuide:
    return view[keyPath: guideSelector]
  case let view as NSLayoutXAxisAnchor:
    return view
  default:
    fatalError()
  }
}

func convertVerticalConstraint(
  _ verticalConstraint    : VerticalConstraint,
  viewSelector            : KeyPath<UIView, NSLayoutYAxisAnchor>,
  guideSelector           : KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>) -> NSLayoutYAxisAnchor {

  switch verticalConstraint {
  case let view as UIView:
    return view[keyPath: viewSelector]
  case let view as UILayoutGuide:
    return view[keyPath: guideSelector]
  case let view as NSLayoutYAxisAnchor:
    return view
  default:
    fatalError()
  }
}
