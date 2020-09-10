//
//  ViewController.swift
//  mongKitSample
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKit

import ReactiveSwift
import ReactiveCocoa

class ViewController: Controller<CustomScrollView> {

  override func viewDidLoad() {
    super.viewDidLoad()

    rootView.delegate = self
    
    rootView.backgroundColor = .white
    rootView.alwaysBounceVertical = true

    scope += rootView.line2.reactive.text
          <~ rootView.textField.reactive.continuousTextValues
  }
}

extension ViewController: CustomScrollViewDelegate {
  func showDeets() {
    present(ViewController(), animated: true, completion: nil)
  }
}
