//
//  UILabel+Style.swift
//  mongKit
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Text<Target: UILabel>: StyleConfiguration {
  public typealias Comp = Target

  public var value: String

  public init(value: String) {
    self.value = value
  }

  public func apply(_ target: Comp) {
    target.text = value
  }
}

public struct ForegroundColor<Target: UILabel>: StyleConfiguration {
  public typealias Comp = Target

  public var value: UIColor

  public init(value: UIColor) {
    self.value = value
  }

  public func apply(_ target: Target) {
    target.textColor = value
  }
}

public struct Alignment<Target: UILabel>: StyleConfiguration {
  public typealias Comp = Target

  public var value: NSTextAlignment

  public init(value: NSTextAlignment) {
    self.value = value
  }

  public func apply(_ target: Target) {
    target.textAlignment = value
  }
}

/**
 Changes `font` and `textColor` for a `UILabel` type.
 */
public struct Header<Target: UILabel>: StyleConfiguration {
  public typealias Comp = Target

  public init() { }

  public func apply(_ target: Target) {
    target.font = .systemFont(ofSize: 30, weight: .bold)
    target.textColor = .black
  }
}
