//
//  Configuration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

/**
 Provides conformance for configuring a particular `Component`.
 */
public protocol Configuration {
  associatedtype Comp: Component
}
