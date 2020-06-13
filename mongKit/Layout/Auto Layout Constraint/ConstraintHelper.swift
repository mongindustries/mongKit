//
//  ConstraintHelper.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

func generateEqualConstraint(for view: UIView, _ prop: KeyPath<UIView, NSLayoutXAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>, to horizontalTarget: HorizontalConstraint) -> NSLayoutConstraint {

  switch horizontalTarget {
  case let anchor as NSLayoutXAxisAnchor:
    return view[keyPath: prop].constraint(equalTo: anchor)

  case let target as UIView:
    return view[keyPath: prop].constraint(equalTo: target[keyPath: prop])

  case let uilg as UILayoutGuide:
    return view[keyPath: prop].constraint(equalTo: uilg[keyPath: guideProp])
  default:
    return .init()
  }
}

func generateGreaterConstraint(for view: UIView, _ prop: KeyPath<UIView, NSLayoutXAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>, to horizontalTarget: HorizontalConstraint) -> NSLayoutConstraint {

  switch horizontalTarget {
  case let anchor as NSLayoutXAxisAnchor:
    return view[keyPath: prop].constraint(greaterThanOrEqualTo: anchor)

  case let target as UIView:
    return view[keyPath: prop].constraint(greaterThanOrEqualTo: target[keyPath: prop])

  case let uilg as UILayoutGuide:
    return view[keyPath: prop].constraint(greaterThanOrEqualTo: uilg[keyPath: guideProp])
  default:
    return .init()
  }
}

func generateLesserConstraint(for view: UIView, _ prop: KeyPath<UIView, NSLayoutXAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutXAxisAnchor>, to horizontalTarget: HorizontalConstraint) -> NSLayoutConstraint {

  switch horizontalTarget {
  case let anchor as NSLayoutXAxisAnchor:
    return view[keyPath: prop].constraint(lessThanOrEqualTo: anchor)

  case let target as UIView:
    return view[keyPath: prop].constraint(lessThanOrEqualTo: target[keyPath: prop])

  case let uilg as UILayoutGuide:
    return view[keyPath: prop].constraint(lessThanOrEqualTo: uilg[keyPath: guideProp])
  default:
    return .init()
  }
}


func generateEqualConstraint(for view: UIView, _ prop: KeyPath<UIView, NSLayoutYAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>, to horizontalTarget: VerticalConstraint) -> NSLayoutConstraint {

  switch horizontalTarget {
  case let anchor as NSLayoutYAxisAnchor:
    return view[keyPath: prop].constraint(equalTo: anchor)

  case let target as UIView:
    return view[keyPath: prop].constraint(equalTo: target[keyPath: prop])

  case let uilg as UILayoutGuide:
    return view[keyPath: prop].constraint(equalTo: uilg[keyPath: guideProp])
  default:
    return .init()
  }
}

func generateGreaterConstraint(for view: UIView, _ prop: KeyPath<UIView, NSLayoutYAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>, to horizontalTarget: VerticalConstraint) -> NSLayoutConstraint {

  switch horizontalTarget {
  case let anchor as NSLayoutYAxisAnchor:
    return view[keyPath: prop].constraint(greaterThanOrEqualTo: anchor)

  case let target as UIView:
    return view[keyPath: prop].constraint(greaterThanOrEqualTo: target[keyPath: prop])

  case let uilg as UILayoutGuide:
    return view[keyPath: prop].constraint(greaterThanOrEqualTo: uilg[keyPath: guideProp])
  default:
    return .init()
  }
}

func generateLesserConstraint(for view: UIView, _ prop: KeyPath<UIView, NSLayoutYAxisAnchor>, _ guideProp: KeyPath<UILayoutGuide, NSLayoutYAxisAnchor>, to horizontalTarget: VerticalConstraint) -> NSLayoutConstraint {

  switch horizontalTarget {
  case let anchor as NSLayoutYAxisAnchor:
    return view[keyPath: prop].constraint(lessThanOrEqualTo: anchor)

  case let target as UIView:
    return view[keyPath: prop].constraint(lessThanOrEqualTo: target[keyPath: prop])

  case let uilg as UILayoutGuide:
    return view[keyPath: prop].constraint(lessThanOrEqualTo: uilg[keyPath: guideProp])
  default:
    return .init()
  }
}
