//
//  Controller.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

open class Controller<Root: View>: UIViewController {
  open override func loadView() {
    view = Root(frame: .zero)
  }
}
