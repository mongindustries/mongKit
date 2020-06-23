//
//  Controller.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
import ReactiveSwift

/**
 Base class for a strongly-typed `UIViewController`.
 */
open class Controller<Root: UIView & CodedView>: UIViewController, Scopeable {

  /**
   The root view of this controller.
   */
  public var rootView: Root { view as! Root }

  /**
   Special property for observable lifetimes.
   */
  public let scope = ScopedDisposable(CompositeDisposable())

  deinit {
    ControllerState.instance.dereference(self)
  }

  open override func loadView() {
    view = Root(frame: .zero)
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    ControllerState.instance.reference(self)
  }
}
