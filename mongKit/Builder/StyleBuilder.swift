//
//  StyleBuilder.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
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


  #if swift(<5.2) // this does not compile on 5.3: ambiguous use of 'init(for:_:)'

  public init<V: UIView, Style: StyleConfiguration>(for: V.Type, _ item: () -> Style) {
    styles = [ item().any ]
  }

  #endif

  public init<V: UIView>(for: V.Type, @StyleBuilder<V> _ builder: () -> CompositeStyleConfiguration<V>) {
    styles = builder().styles
  }
}
