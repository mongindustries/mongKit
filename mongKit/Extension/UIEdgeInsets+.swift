//
//  UIEdgeInsets+.swift
//  mongKit
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
  public init(all: CGFloat) {
    self.init(top: all, left: all, bottom: all, right: all)
  }

  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }

  public init(top: CGFloat, sides: CGFloat, bottom: CGFloat) {
    self.init(top: top, left: sides, bottom: bottom, right: sides)
  }
}
