//
//  ViewBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKitCore

@_functionBuilder
public struct ComponentBuilder {

  public static func buildBlock<C: Component>
    (_ item: C) -> Component {
      item }

  public static func buildBlock
    (_ items: Component...) -> Component {
      Components.Group(items: items) }


  public static func buildIf
    (_ item: Component?) -> Component {
      item ?? Components.Empty() }

  public static func buildEither
    (first item: Component) -> Component {
      item }

  public static func buildEither
    (second item: Component) -> Component {
      item }
}
