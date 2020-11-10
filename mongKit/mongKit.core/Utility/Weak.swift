//
//  Weak.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

/**
 A value type that wraps a class-type instace to denote weakly
 linked reference.
 */
@propertyWrapper
public struct Weak<Type: AnyObject> {

  public weak var wrappedValue: Type?

  public init(wrappedValue: Type?) {
    self.wrappedValue = wrappedValue
  }
}
