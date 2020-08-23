//
//  CustomScrollView.swift
//  mongKitSample
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import mongKit

protocol CustomScrollViewDelegate: UIScrollViewDelegate {
  func showDeets()
}

class CustomScrollView: ScrollView {

  weak var line2: UILabel!

  weak var textField: UITextField!

  @ComponentBuilder override var body: Component {
    UIStackView {
      Style(for: UIStackView.self) {
        VerticalStack(spacing: 8, alignment: .fill)
        LayoutMarginStack(value: .init(top: 10, left: 10, bottom: 20, right: 10))
      }
      AutoLayout {
        Edge    (self)
        Width   (self)
      }
      
      UIView {
        Style(for: UIView.self) {
          \.backgroundColor ==> .blue
        }
        AutoLayout {
          Height(400)
        }
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

      UIButton {
        Style(for: UIButton.self) {
          Ref{
            $0.setTitle("Show", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(self.doDeets), for: .touchUpInside)
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
