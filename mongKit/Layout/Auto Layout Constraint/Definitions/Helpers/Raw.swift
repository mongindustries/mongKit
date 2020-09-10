//
//  Raw.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Raw: Constraint {

  public let constraint: (Weak<UIView>) -> [NSLayoutConstraint]

  public init(_ raw: @escaping () -> NSLayoutConstraint) {
    constraint = { _ in [ raw() ] }
  }

  public init(_ raw: @escaping (Weak<UIView>) -> NSLayoutConstraint) {
    constraint = { [ raw($0) ] }
  }
  
  public init(_ raw: @escaping (Weak<UIView>) -> [NSLayoutConstraint]) {
    constraint = { raw($0) }
  }
}
