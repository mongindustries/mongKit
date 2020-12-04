//
//  Language.swift
//  mongKit
//
//  Created by Michael Ong on 18/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

/**
 Obtains an class-type instance and tells it to
 configure using a user-specified block.
 - Parameters:
    - target: The instance to apply.
    - builder: The block to configure the instance.
 - Returns: The newly created instance.
 */
@discardableResult public func tell<Target>(_ target: Target, _ builder: (inout Target) -> Void) -> Target {
  var back = target // COW this shit
  builder(&back)
  return back
}

/**
 Obtains an optional class-type instance and tells it to
 configure using a user-specified block if the instance exists.
 - Parameters:
    - target: The instance to apply.
    - builder: The block to configure the instance.
 - Returns: The newly created instance.
 */
@discardableResult public func tell<Target>(fromOptional target: Target?, _ builder: (inout Target) -> Void) -> Target? {

  guard var back = target else { // COW this shit
    return nil
  }

  builder(&back)
  return back
}

/**
 Given an instance, transform the instance whilst applying properties defined in the block.
 - Parameters:
 - target: The instance to apply.
 - transform: The block to configure the instance.
 - Returns: The newly created instance.
 */
public func apply<Target, Return>(_ target: Target, _ transform: (inout Target) -> Return) -> Return {

  var back = target
  return transform(&back)
}

extension NSObject {

  /**
   Given an instance, apply properties defined in the block.
   */
  func apply<Target>(to target: (Target) -> Void) {
    target(self as! Target)
  }

  /**
   Given an instance, apply properties defined in the block.
   */
  func apply<Target, V1>(_ v1: V1, to target: (Target, V1) -> Void) {
    target(self as! Target, v1)
  }
  
  /**
   Given an instance, apply properties defined in the block.
   */
  func apply<Target, V1, V2>(_ v1: V1, _ v2: V2, to target: (Target, V1, V2) -> Void) {
    target(self as! Target, v1, v2)
  }
}
