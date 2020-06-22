//
//  Weak.swift
//  mongKit
//
//  Created by Michael Ong on 19/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public struct WeakReference<Type: AnyObject> {
  weak var instance: Type?

  subscript<Value>(dynamicMember path: KeyPath<Type, Value>) -> Value? {
    return instance?[keyPath: path]
  }
}
