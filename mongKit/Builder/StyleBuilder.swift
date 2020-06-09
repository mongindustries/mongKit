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

  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration>
    (_ c0: C0, _ c1: C1) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any ])
  }

  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration,
    C4: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any, c4.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration,
    C4: StyleConfiguration,
    C5: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any, c4.any, c5.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration,
    C4: StyleConfiguration,
    C5: StyleConfiguration,
    C6: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any, c4.any, c5.any, c6.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration,
    C4: StyleConfiguration,
    C5: StyleConfiguration,
    C6: StyleConfiguration,
    C7: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any, c4.any, c5.any, c6.any, c7.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration,
    C4: StyleConfiguration,
    C5: StyleConfiguration,
    C6: StyleConfiguration,
    C7: StyleConfiguration,
    C8: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any, c4.any, c5.any, c6.any, c7.any, c8.any ])
  }
  public static func buildBlock<
    C0: StyleConfiguration,
    C1: StyleConfiguration,
    C2: StyleConfiguration,
    C3: StyleConfiguration,
    C4: StyleConfiguration,
    C5: StyleConfiguration,
    C6: StyleConfiguration,
    C7: StyleConfiguration,
    C8: StyleConfiguration,
    C9: StyleConfiguration>
    (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> CompositeStyleConfiguration<Target> {
    CompositeStyleConfiguration(styles: [ c0.any, c1.any, c2.any, c3.any, c4.any, c5.any, c6.any, c7.any, c8.any, c9.any ])
  }
}

public class Style {

  let styles: [AnyStyleConfiguration]

  public init() {
    styles = []
  }

  public init<V: UIView, C: StyleConfiguration>(for: V.Type, _ style: () -> C) where C.Comp == V {
    styles = [ style().any ]
  }

  public init<V: UIView>(for: V.Type, @StyleBuilder<V> _ builder: () -> CompositeStyleConfiguration<V>) {
    styles = builder().styles
  }
}
