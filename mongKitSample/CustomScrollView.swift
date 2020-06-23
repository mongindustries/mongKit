//
//  CustomScrollView.swift
//  mongKitSample
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKit

class CustomScrollView: ScrollView {

  weak var line2: UILabel!

  weak var textField: UITextField!

  override var body: Component {
    UIStackView {
      Style(for: UIStackView.self) {
        VerticalStack(spacing: 8, alignment: .fill)
        LayoutMarginStack(value: .init(top: 10, left: 10, bottom: 20, right: 10))
      }
      AutoLayout {
        Edge    (self)
        Width   (self)
      }
      UILabel {
        Style(for: UILabel.self) {
          Text(value: "Line 1")
        }
      }
      UILabel {
        Style(for: UILabel.self) {
          Ref { self.line2 = $0 }
          Text(value: "Line 2")
        }
      }

      UITextField {
        Style(for: UITextField.self) {
          Ref { self.textField = $0 }
          Property(\UITextField.borderStyle,
                   value: UITextField.BorderStyle.roundedRect)
        }
      }

      UIView {
        Style(for: UIView.self) {
          SpacerStack(axis: [ .vertical ])
        }
      }
    }
  }
}
