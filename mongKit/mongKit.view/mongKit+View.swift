//
//  mongKit.swift
//  mongKit
//
//  Created by Michael Ong on 6/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

/**
 Module class for mongKit
 */
extension mongKit {

  private func swizzleUIViewDidMoveToSubview() {

    let orig_method = class_getInstanceMethod(UIView.self,  #selector(UIView  .didMoveToSuperview))
    let swzz_method = class_getInstanceMethod(mongKit.self, #selector(mongKit .didMoveToSuperview))

    let imp         = method_getImplementation(swzz_method!)

    method_setImplementation(orig_method!, imp)
  }

  private func scanLayouts(for view: UIView) {
    guard view.mongConstructed else {
      return
    }

    if view.superview != nil {
      view.layout?.apply(view)
      view.layout = nil
    }

    for subview in view.subviews {
      scanLayouts(for: subview)
    }
  }

  @objc
  private func didMoveToSuperview() {

    let this = unsafeBitCast(self, to: UIView.self)

    scanLayouts(for: this)
  }


  /**
   Call this method so that mongKit can initialize its thing.
   */
  public static func initialize() {

    let instance = mongKit.instance
    instance.swizzleUIViewDidMoveToSubview()
  }
}
