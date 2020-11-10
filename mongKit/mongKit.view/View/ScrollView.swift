//
//  ScrollView.swift
//  mongKit
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

import mongKitCore
import mongKitStructure

import ReactiveSwift

private class KeyboardDismissHandler: UITapGestureRecognizer, UIGestureRecognizerDelegate {
  override init(target: Any?, action: Selector?) {
    super.init(target: target, action: action)
    self.delegate = self
  }

  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

    guard let view = self.view else {
      return false
    }

    let hasView = scanSubviews(parent: view)
      .compactMap { $0 as? UIControl }
      .first      { $0.convert($0.bounds, to: view).contains(gestureRecognizer.location(in: view)) }

    return hasView == nil
  }

  // meh...
  private func scanSubviews(parent: UIView) -> [ UIView ] { [ parent ] + parent.subviews.flatMap { scanSubviews(parent: $0) } }
}

open class ScrollView: UIScrollView, CodedView {

  open var body: Component {
    Components.Empty()
  }

  let __scope = ScopedDisposable(CompositeDisposable())

  public required override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview {
      body
    }

    addGestureRecognizer(tell(KeyboardDismissHandler()) {
      __scope += $0.reactive.stateChanged.observeValues { [unowned self] _ in
        self.endEditing(true)
      }
    })
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    addSubview {
      body
    }

    addGestureRecognizer(tell(KeyboardDismissHandler()) {
      __scope += $0.reactive.stateChanged.observeValues { [unowned self] _ in
        self.endEditing(true)
      }
    })
  }

  open override func layoutSubviews() {
    super.layoutSubviews()

    if let viewController = next as? BaseController {
      
      contentInset =
        .init(top: 0, sides: 0, bottom: viewController.__mngkit_state.bottomOffset - safeAreaInsets.bottom)
      scrollIndicatorInsets =
        .init(top: 0, sides: 0, bottom: viewController.__mngkit_state.bottomOffset - safeAreaInsets.bottom)
    }
  }
}
