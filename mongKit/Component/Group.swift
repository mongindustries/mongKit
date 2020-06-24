//
//  Group.swift
//  mongKit
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

public struct Group: Component {
  let items: [ Component ]

  public init(items: [ Component ]) {
    self.items = items
  }
}
