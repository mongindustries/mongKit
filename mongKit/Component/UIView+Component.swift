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

  public func addSubview(@ComponentBuilder _ builder: () -> Component) {
    buildChildren(builder())
  }

  public func replaceViews(@ComponentBuilder with builder: () -> Component) {
    self.subviews.forEach { $0.removeFromSuperview() }

    buildChildren(builder())
  }
}
