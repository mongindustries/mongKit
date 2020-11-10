//
//  Style.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/22/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public class Style<Target: UIView>: StyleConfiguration {
  
  public typealias Comp = Target

  let styles: ErasedStyleConfiguration

  public init() {
    styles = ErasedStyleConfiguration([])
  }

  public init(@StyleBuilder<Target> _ builder: () -> ErasedStyleConfiguration) {
    styles = builder()
  }

  public func apply(_ target: Target) {
    styles.apply(target)
  }
}
