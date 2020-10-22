//
//  CustomScrollView.swift
//  mongKitSample
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKit

protocol CustomScrollViewDelegate: UIScrollViewDelegate {
  func showDeets()
}

class CustomScrollView: ScrollView {

  weak var content: UIStackView!
  
  weak var line2: UILabel!

  weak var textField: UITextField!

  @ComponentBuilder override var body: Component {
    UIStackView(
      style: Style(for: UIStackView.self) {
        StackVertical(spacing: 8, alignment: .fill)
        StackMargin(value: .init(top: 10, left: 10, bottom: 20, right: 10))
        Ref(self, ref: \.content) },
      layout: AutoLayout {
        Edge()
        Width.equalTo(self, constraint: \.widthAnchor) }) {

      UIView(
        style:  Style(for: UIView.self) {
          \.backgroundColor ~ .blue },
        layout: AutoLayout {
          Height(300) })

      UILabel(
        style: Style(for: UILabel.self) {
          \.text ~ "Line 1" })
      UILabel(
        style: Style(for: UILabel.self) {
          Ref(self, ref: \.line2)
          \.text ~ "Line 2" })

      UITextField(
        style: Style(for: UITextField.self) {
          Ref(self, ref: \.textField)
          \.borderStyle ~ .roundedRect })

      UIButton(
        style: Style(for: UIButton.self) {
          Ref{ [unowned self] (view: UIButton) in
            view.setTitle("Show", for: .normal)
            view.setTitleColor(.black, for: .normal)
            view.addTarget(self, action: #selector(self.doDeets), for: .touchUpInside) } })

      UIView(
        style: Style(for: UIView.self) {
          StackFiller(axis: [ .vertical ]) })
    }
  }
  
  @objc func doDeets() {
    (delegate as? CustomScrollViewDelegate)?.showDeets()
  }
}
