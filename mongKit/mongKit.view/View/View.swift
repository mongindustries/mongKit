//
//  View.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
import mongKitCore

open class View: UIView, CodedView {

  open var body: Component {
    Components.Empty()
  }

  public required override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview {
      body
    }
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)

    addSubview {
      body
    }
  }
}
