//
//  GroupComponent.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
extension Components {
  public struct Group: Component {
    public let items: [Component]

    public init(items: [Component]) {
      self.items = items
    }
  }
}
