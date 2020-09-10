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
    UIStackView {
      Style(for: UIStackView.self) {
        VerticalStack(spacing: 8, alignment: .fill)
        LayoutMarginStack(value: .init(top: 10, left: 10, bottom: 20, right: 10))
        Ref(self, ref: \.content)
      }
      AutoLayout {
        Edge()
        Width.equalTo(self, constraint: \.widthAnchor)
      }

      UIView {
        Style(for: UIView.self) {
          \.backgroundColor ==> .blue
        }
        AutoLayout {
          Height(300)
        }
      }

      UILabel {
        Style(for: UILabel.self) {
          Text(value: "Line 1")
        }
      }
      UILabel {
        Style(for: UILabel.self) {
          Ref(self, ref: \.line2)
          Text(value: "Line 2")
        }
      }

      UITextField {
        Style(for: UITextField.self) {
          Ref { [unowned self] view in self.textField = view }
          Property(\UITextField.borderStyle,
                   value: UITextField.BorderStyle.roundedRect)
        }
      }

      UIButton {
        Style(for: UIButton.self) {
          Ref{ [unowned self] (view: UIButton) in
            view.setTitle("Show", for: .normal)
            view.setTitleColor(.black, for: .normal)
            view.addTarget(self, action: #selector(self.doDeets), for: .touchUpInside)
          }
        }
      }

      UIView {
        Style(for: UIView.self) {
          SpacerStack(axis: [ .vertical ])
        }
      }
    }
  }
  
  @objc func doDeets() {
    (delegate as? CustomScrollViewDelegate)?.showDeets()
  }
}
