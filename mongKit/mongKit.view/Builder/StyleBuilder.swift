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

  public static func buildExpression<C: StyleConfiguration>
  (_ style: C) -> ErasedStyleConfiguration where C.Comp == Target {
    ErasedStyleConfiguration(style)
  }

  public static func buildBlock
  (_ items: ErasedStyleConfiguration...) -> ErasedStyleConfiguration {
    ErasedStyleConfiguration(items)
  }
}
