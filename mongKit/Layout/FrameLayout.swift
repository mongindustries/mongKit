//
//  FrameLayout.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public class FrameLayout: Layout {

  let frame: CGRect

  public init(frame: CGRect) {
    self.frame = frame
  }

  public override func apply(_ target: UIView) {
    target.frame = frame
  }
}
