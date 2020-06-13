//
//  Raw.swift
//  mongKit
//
//  Created by Michael Ong on 13/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Raw: Constraint {

  public let constraint: (UIView) -> NSLayoutConstraint

  public init(_ raw: @escaping () -> NSLayoutConstraint) {
    constraint = { _ in raw() }
  }

  public init(_ raw: @escaping (UIView) -> NSLayoutConstraint) {
    constraint = raw
  }
}
