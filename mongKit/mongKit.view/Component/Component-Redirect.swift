//
//  RedirectComponent.swift
//  mongKit
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
extension Components {
  public struct Redirect: Component {
    let item: () -> Component
  }
}
