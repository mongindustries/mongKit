//
//  LayoutConfiguration.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol LayoutConfiguration: Configuration where Comp == UIView {
  func apply(_ target: Comp)
}
