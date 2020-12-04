//
//  ConstraintHelper.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

func generateEqualConstraint
  (for view: UIView, _ prop: KeyPath<UIView, NSLayoutXAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>, to horizontalTarget: HorizontalConstraint) -> NSLayoutConstraint {

  let item2: NSLayoutXAxisAnchor

  switch horizontalTarget {
  case let anchor as NSLayoutXAxisAnchor:
    item2 = anchor

  case let target as UIView:
    item2 = target[keyPath: prop]

  case let target as UILayoutGuide:
    item2 = target[keyPath: guideProp]

  default:
    fatalError()
  }

  return view[keyPath: prop].constraint(equalTo: item2)
}

func generateGreaterConstraint
  (for view: UIView, _ prop: KeyPath<UIView, NSLayoutXAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>, to horizontalTarget: HorizontalConstraint, multiplier: CGFloat = 1) -> NSLayoutConstraint {

  let item2: NSLayoutXAxisAnchor

  switch horizontalTarget {
  case let anchor as NSLayoutXAxisAnchor:
    item2 = anchor

  case let target as UIView:
    item2 = target[keyPath: prop]

  case let target as UILayoutGuide:
    item2 = target[keyPath: guideProp]

  default:
    fatalError()
  }

  return view[keyPath: prop].constraint(greaterThanOrEqualToSystemSpacingAfter: item2, multiplier: multiplier)
}

func generateLesserConstraint
  (for view: UIView, _ prop: KeyPath<UIView, NSLayoutXAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>, to horizontalTarget: HorizontalConstraint, multiplier: CGFloat = 1) -> NSLayoutConstraint {

  let item2: NSLayoutXAxisAnchor

  switch horizontalTarget {
  case let anchor as NSLayoutXAxisAnchor:
    item2 = anchor

  case let target as UIView:
    item2 = target[keyPath: prop]

  case let target as UILayoutGuide:
    item2 = target[keyPath: guideProp]

  default:
    fatalError()
  }

  return view[keyPath: prop].constraint(lessThanOrEqualToSystemSpacingAfter: item2, multiplier: multiplier)
}


func generateEqualConstraint
  (for view: UIView, _ prop: KeyPath<UIView, NSLayoutYAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>, to horizontalTarget: VerticalConstraint) -> NSLayoutConstraint {

  let item2: NSLayoutYAxisAnchor

  switch horizontalTarget {
  case let anchor as NSLayoutYAxisAnchor:
    item2 = anchor

  case let target as UIView:
    item2 = target[keyPath: prop]

  case let target as UILayoutGuide:
    item2 = target[keyPath: guideProp]

  default:
    fatalError()
  }

  return view[keyPath: prop].constraint(equalTo: item2)
}

func generateGreaterConstraint
  (for view: UIView, _ prop: KeyPath<UIView, NSLayoutYAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>, to horizontalTarget: VerticalConstraint, multiplier: CGFloat = 1) -> NSLayoutConstraint {

  let item2: NSLayoutYAxisAnchor

  switch horizontalTarget {
  case let anchor as NSLayoutYAxisAnchor:
    item2 = anchor

  case let target as UIView:
    item2 = target[keyPath: prop]

  case let target as UILayoutGuide:
    item2 = target[keyPath: guideProp]

  default:
    fatalError()
  }

  return view[keyPath: prop].constraint(greaterThanOrEqualToSystemSpacingBelow: item2, multiplier: multiplier)
}

func generateLesserConstraint
  (for view: UIView, _ prop: KeyPath<UIView, NSLayoutYAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>, to horizontalTarget: VerticalConstraint, multiplier: CGFloat = 1) -> NSLayoutConstraint {

  let item2: NSLayoutYAxisAnchor

  switch horizontalTarget {
  case let anchor as NSLayoutYAxisAnchor:
    item2 = anchor

  case let target as UIView:
    item2 = target[keyPath: prop]

  case let target as UILayoutGuide:
    item2 = target[keyPath: guideProp]

  default:
    fatalError()
  }

  return view[keyPath: prop].constraint(lessThanOrEqualToSystemSpacingBelow: item2, multiplier: multiplier)
}
