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

  let styles: [ErasedStyleConfiguration]

  public init() {
    styles = []
  }

  public init(@StyleBuilder<Target> _ builder: () -> CompositeStyleConfiguration<Target>) {
    styles = []
  }

  public func apply(_ target: Target) {

  }
}
