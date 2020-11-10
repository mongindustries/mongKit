//
//  Ref.swift
//  mongKit
//
//  Created by Michael Ong on 29/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

public struct Ref<Target> {
  public let __apply: (Any) -> Void
  
  public init(__apply: @escaping (Any) -> Void) {
    self.__apply = __apply
  }
}
