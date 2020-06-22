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

  weak var container: UIView!

  weak var line1: UILabel!

  weak var line2: UILabel!


  override func viewDidLoad() {
    super.viewDidLoad()

    mongKit.initialize()

    let salg = view.safeAreaLayoutGuide

    view.addSubview {
      UIStackView {
        Style(for: UIStackView.self) {
          VerticalStack(spacing: 10)
          LayoutMarginStack(value: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
          Ref { (v: UIView) in self.container = v } }

        AutoLayout {
          Leading   (equalTo: salg)
          Trailing  (equalTo: salg)
          Top       (equalTo: salg) }

        UILabel {
          Style(for: UILabel.self) {
            Ref { (v: UILabel) in self.line1 = v }
            Header()
            Text(value: "Hello world!") }
          Layout() }

        UILabel {
          Style(for: UILabel.self) {
            Ref { (v: UILabel) in self.line2 = v }
            Text(value: "Nice to meet you!") }
          Layout() }

        UIView {
          Style(for: UIView.self) {
            SpacerStack(axis: [ .vertical ]) } } } }
  }
}
