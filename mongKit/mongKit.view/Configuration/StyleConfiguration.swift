//
//  StyleConfiguration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

public protocol StyleConfiguration: Configuration {
  func apply(_ target: Comp)
}
