//
//  Ref+Constraint.swift
//  mongKit
//
//  Created by Michael Ong on 29/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
 

public struct ConstraintRef {
    public let target: Constraint.Type
    public let reference: NSLayoutConstraint
}

extension Ref: ConstraintModifier where Target: NSLayoutConstraint {

    public init(_ value: @escaping (ConstraintRef) -> Void) {
      self.init(__apply: { any in value(any as! ConstraintRef) })
    }

    public func apply(target: Constraint.Type, _ constraint: NSLayoutConstraint) {
        __apply(ConstraintRef(target: target, reference: constraint))
    }
}
