//
//  UIView+Component.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

/**
 This extension provides support for view building for all UIKit view types.
 */
extension UIView: Component {
  public func addSubview(_ view: () -> UIView) {
    addSubview(view())
  }
}
