//
//  GroupComponent.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

public struct GroupComponent: Component {
  let items: [Component]

  public init(items: [Component]) {
    self.items = items
  }
}
