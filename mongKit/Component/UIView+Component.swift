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

  private func constructComponent(_ component: Component) {
    switch component {
    case let list as ArrayComponent:
      list.items.forEach(constructComponent(_:))
    case let view as UIView:
      addSubview(view)
    default:
      break
    }
  }

  public func addSubview(@ComponentBuilder _ builder: () -> Component) {
    constructComponent(builder())
  }
}
