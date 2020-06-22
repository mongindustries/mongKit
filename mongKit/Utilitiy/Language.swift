//
//  Language.swift
//  mongKit
//
//  Created by Michael Ong on 18/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

@discardableResult
public func tell<Target: AnyObject>(_ target: Target, _ builder: (Target) -> Void) -> Target {
  builder(target)
  return target
}

public func apply<Target, Return>(_ target: Target, _ transform: (Target) -> Return) -> Return {
  transform(target)
}
