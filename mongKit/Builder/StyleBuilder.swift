//
//  StyleBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

@_functionBuilder
public struct StyleBuilder<Target: UIView> {

  public static func buildExpression<C: StyleConfiguration>(
    _ style: C) -> AnyStyleConfiguration where C.Comp == Target {
    style.any
  }

  public static func buildBlock(_ items: AnyStyleConfiguration...) -> CompositeStyleConfiguration<Target> {
    .init(styles: items)
  }
}

public class Style {

  let styles: [AnyStyleConfiguration]

  public init() {
    styles = []
  }

  public init<V: UIView>(for: V.Type, @StyleBuilder<V> _ builder: () -> CompositeStyleConfiguration<V>) {
    styles = builder().styles
  }
}
