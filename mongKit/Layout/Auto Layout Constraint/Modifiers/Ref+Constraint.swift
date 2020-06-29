//
//  Ref+Constraint.swift
//  mongKit
//
//  Created by Michael Ong on 29/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct ConstraintRef {
    public let target: Constraint.Type
    public let reference: NSLayoutConstraint
}

extension Ref: ConstraintModifier where Target: NSLayoutConstraint {

    public init(_ value: @escaping (ConstraintRef) -> Void) {
        __apply = { any in value(any as! ConstraintRef)}
    }

    public func apply<Target>(target: Target.Type, _ constraint: NSLayoutConstraint) where Target : Constraint {
        __apply(ConstraintRef(target: target, reference: constraint))
    }
}
