//
//  FrameLayout.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct FrameLayout: LayoutConfiguration {

  let frame: CGRect

  public init(frame: CGRect) {
    self.frame = frame
  }

  public func apply(_ target: UIView) {
    target.frame = frame
  }
}
