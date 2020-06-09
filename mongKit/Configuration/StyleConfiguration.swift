//
//  StyleConfiguration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol StyleConfiguration: Configuration {

  associatedtype ApplyType

  var value: ApplyType { get }

  func apply(_ target: Comp)
}

extension StyleConfiguration {
  public var any: AnyStyleConfiguration {
    return .init(self)
  }
}

public struct AnyStyleConfiguration: StyleConfiguration {

  public typealias Comp = UIView

  public let value: () -> Any

  let apply: (Comp) -> Void

  public init<Config: StyleConfiguration>(_ style: Config) {
    value = { style.value }
    apply = { c in style.apply(c as! Config.Comp) }
  }

  public func apply(_ target: Comp) {
    apply(target)
  }
}

public struct CompositeStyleConfiguration<Target: UIView>: Configuration {
  public typealias Comp = Target

  let styles: [AnyStyleConfiguration ]
}
