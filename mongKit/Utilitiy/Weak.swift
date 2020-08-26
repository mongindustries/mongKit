//
//  Weak.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Weak<Type: AnyObject> {

  public weak var wrappedValue: Type?

  public init(wrappedValue: Type?) {
    self.wrappedValue = wrappedValue
  }
}
