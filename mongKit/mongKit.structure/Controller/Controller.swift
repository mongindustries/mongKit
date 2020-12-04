//
//  Controller.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import Foundation
import UIKit

import ReactiveSwift
import ReactiveCocoa

open class BaseController: UIViewController, Scopeable {

  public var __mngkit_visible: Bool = false

  var hookedViews = [UIView:UIEdgeInsets]()

  /**
   Special property for observable lifetimes.
   */
  public let scope = ScopedDisposable(CompositeDisposable())

  open override func viewWillDisappear  (_ animated: Bool) {
    super.viewWillDisappear(animated)

    __mngkit_visible = false
  }

  open override func viewDidAppear      (_ animated: Bool) {
    super.viewWillAppear(animated)

    __mngkit_visible = true
  }


  public func hookKeyboardInsets        (to view: UIView) {
    
  }

  public func hookKeyboardInsets        (to scrollView: UIScrollView) {

    scope += NotificationCenter.default.reactive
      .keyboard       (.willShow)
      .observeValues  { [unowned self, unowned scrollView] context in
        if !hookedViews.keys.contains(scrollView) {
          hookedViews[scrollView] = scrollView.contentInset
        }
        scrollView.contentInset = .init(
          top     : scrollView.contentInset.top,
          left    : scrollView.contentInset.left,
          bottom  : context.endFrame.maxY - context.endFrame.minY - scrollView.safeAreaInsets.bottom,
          right   : scrollView.contentInset.right)

        scrollView.scrollIndicatorInsets = .init(
          top     : 0,
          left    : 0,
          bottom  : context.endFrame.maxY - context.endFrame.minY - scrollView.safeAreaInsets.bottom,
          right   : 0)
      }

    scope += NotificationCenter.default.reactive
      .keyboard       (.didHide)
      .observeValues  { [unowned self, unowned scrollView] context in
        scrollView.scrollIndicatorInsets  = .zero
        scrollView.contentInset           = hookedViews[scrollView] ?? .zero

        hookedViews.removeValue(forKey: scrollView)
      }
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
