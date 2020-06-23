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

    var inside1: UILabel!
    var inside2: UILabel!

    view.addSubview {
      UIStackView {
        Style(for: UIStackView.self) {
          VerticalStack(spacing: 10)
          Ref{ (v: UIView) in self.container = v } }

        AutoLayout {
          Leading(equalTo: salg) {
            Inset(10)
          }
          Trailing(equalTo: salg) {
            Inset(10)
          }
          Top(equalTo: salg) }

        UILabel {
          Style(for: UILabel.self) {
            Ref{ (v: UILabel) in self.line1 = v }
            Header()
            Text(value: "Hello world!") }
          Layout() }

        UILabel {
          Style(for: UILabel.self) {
            Ref{ (v: UILabel) in self.line2 = v }
            Text(value: "Nice to meet you!") }
          Layout() }

        UIView {

          Style (for: UIView.self) {
            BackgroundColor(value: .white) }
          Layout()

          UILabel {
            Style(for: UILabel.self) {
              Text(value: "Textoo")
              Ref{ inside1 = $0 } }
            AutoLayout {
              Leading ()
              Top     ()
              Bottom  () } }

          UILabel {
            Style(for: UILabel.self) {
              Property(\UILabel.numberOfLines, value: 4)
              Text(value: "Textoo222\nYehesss")
              Ref{ inside2 = $0 } }
            AutoLayout {
              Leading(equalTo: inside1.trailingAnchor) {
                Constant(10) }
              Trailing()
              Raw { (view: UIView) -> NSLayoutConstraint in
                view.firstBaselineAnchor.constraint(equalTo: inside1.firstBaselineAnchor) } } } }

        UIView {
          Style(for: UIView.self) {
            SpacerStack(axis: [ .vertical ]) } } } }
  }
}
