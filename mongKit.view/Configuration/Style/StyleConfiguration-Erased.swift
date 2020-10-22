//
//  ErasedStyleConfiguration.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/22/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public struct ErasedStyleConfiguration: StyleConfiguration {
  public typealias Comp = UIView

  let applyBlock: (UIView) -> Void
  
  public init<Target: StyleConfiguration>(_ prop: Target) {
    applyBlock = { view in prop.apply(view as! Target.Comp) }
  }
  
  public func apply(_ target: UIView) {
    applyBlock(target)
  }
}
