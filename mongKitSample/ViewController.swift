//
//  ViewController.swift
//  mongKitSample
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKit

class ViewController: UIViewController {

  var container: UIView!

  var line1: UILabel!

  var line2: UILabel!


  override func viewDidLoad() {
    super.viewDidLoad()

    mongKit.initialize()

    view.addSubview(UIStackView {
      Style(for: UIView.self) {
        VerticalStack(spacing: 10)
        LayoutMarginStack(value: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        Ref { self.container = $0 } }
      AutoLayout {
        Raw { self.container.leadingAnchor  .constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor  ) }
        Raw { self.container.trailingAnchor .constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor ) }
        Raw { self.container.topAnchor      .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor      ) } }

      UILabel {
        Style(for: UILabel.self) {
          Ref { (r: UILabel) in self.line1 = r }
          Text(value: "Hello world!") }
        Layout() }

      UILabel {
        Style(for: UILabel.self) {
          Ref { (r: UILabel) in self.line2 = r }
          Text(value: "Nice to meet you!") }
        Layout() }
    })
  }
}
