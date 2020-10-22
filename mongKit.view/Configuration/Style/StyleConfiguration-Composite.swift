//
//  StyleConfiguration-Composite.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/22/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public struct CompositeStyleConfiguration<Target: UIView>: StyleConfiguration {
  
  public typealias Comp = Target

  public init(config: [ ErasedStyleConfiguration ]) {

  }
  
  public func apply(_ target: Target) {

  }
}
