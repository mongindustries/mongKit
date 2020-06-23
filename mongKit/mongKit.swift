//
//  mongKit.swift
//  mongKit
//
//  Created by Michael Ong on 6/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

/**
 Module class for mongKit
 */
public class mongKit {

  private func swizzleUIViewDidMoveToSubview() {

    let orig_method = class_getInstanceMethod(UIView.self,  #selector(UIView  .didMoveToSuperview))
    let swzz_method = class_getInstanceMethod(mongKit.self, #selector(mongKit .didMoveToSuperview))

    let imp         = method_getImplementation(swzz_method!)

    method_setImplementation(orig_method!, imp)
  }

  @objc
  private func didMoveToSuperview(_: Any, selector: Selector) {

    let this = unsafeBitCast(self, to: UIView.self)

    if this.mongConstructed, let parent = this.superview, parent.mongConstructed == false, let layout = this.layout {
      layout.apply(this)

      for sublayout in this.sublayouts {
        sublayout.layout.apply(sublayout.view!)
      }
    }
  }


  /**
   Call this method so that mongKit can initialize its thing.
   */
  public static func initialize() {

    let instance = mongKit()
    instance.swizzleUIViewDidMoveToSubview()
  }
}
