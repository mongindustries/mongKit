//
//  ViewController.swift
//  mongKitSample
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKit

import ReactiveSwift
import ReactiveCocoa

class ViewController: Controller<CustomScrollView> {

  override func viewDidLoad() {
    super.viewDidLoad()

    rootView.backgroundColor = .white
    rootView.alwaysBounceVertical = true

    scope += rootView.line2.reactive.text
          <~ rootView.textField.reactive.continuousTextValues
  }
}
