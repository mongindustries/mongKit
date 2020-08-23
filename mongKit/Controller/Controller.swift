//
//  Controller.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import Foundation
import UIKit

import ReactiveSwift
import ReactiveCocoa

open class BaseController: UIViewController, Scopeable {
  
  struct __mngkit_State {
    var bottomOffset: CGFloat = 0
  }

  var __mngkit_state: __mngkit_State = .init(bottomOffset: 0)
  
  var __mngkit_visible: Bool = false
  
  /**
   Special property for observable lifetimes.
   */
  public let scope = ScopedDisposable(CompositeDisposable())
  
  open override func viewDidLoad() {
    super.viewDidLoad()

    scope += NotificationCenter
      .default
      .reactive
      .keyboard       (.willHide)
      .filter         { [unowned self] _ in self.__mngkit_visible }
      .observeValues  { [unowned self] context in

        var newState              = self.__mngkit_state
            newState.bottomOffset = 0

        self.__mngkit_state = newState

        self.view.setNeedsLayout()

        tell(UIViewPropertyAnimator(duration: context.animationDuration, curve: context.animationCurve)) {
          $0.addAnimations { [unowned self] in
            self.view.layoutIfNeeded()
          }
        }.startAnimation()
      }

    scope += NotificationCenter
      .default
      .reactive
      .keyboard       (.willShow)
      .filter         { [unowned self] _ in self.__mngkit_visible }
      .observeValues  { [unowned self] context in

        var newState              = self.__mngkit_state
            newState.bottomOffset = context.endFrame.height

        __mngkit_state = newState

        self.view.setNeedsLayout()

        tell(UIViewPropertyAnimator(duration: context.animationDuration, curve: context.animationCurve)) {
          $0.addAnimations { [unowned self] in
            self.view.layoutIfNeeded()
          }
        }.startAnimation()
      }
  }
  

  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    __mngkit_visible = false
  }
  
  open override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    __mngkit_visible = true
  }
}

/**
 Base class for a strongly-typed `UIViewController`.
 */
open class Controller<Root: UIView & CodedView>: BaseController {

  /**
   The root view of this controller.
   */
  public var rootView: Root { view as! Root }


  open override func loadView() {
    view = Root(frame: .zero)
  }
}
