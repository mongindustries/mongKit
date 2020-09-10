//
//  ViewBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

@_functionBuilder
public struct ComponentBuilder {

  public static func buildBlock<C: Component>(_ item: C) -> Component {
    item
  }

  public static func buildBlock(_ items: Component...) -> Component {
    GroupComponent(items: items)
  }
}
