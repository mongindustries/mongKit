//
//  ControllerState.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

import ReactiveSwift
import ReactiveCocoa

class ControllerState {

  struct State {
    var bottomOffset: CGFloat = 0
  }

  static var instance = ControllerState()

  private var handles = [ (controller: UIViewController & Scopeable, state: State) ]()


  func reference<View: UIView>    (_ controller: Controller<View>) {
    handles.append((controller: controller, state: State()))

    controller.scope += NotificationCenter
      .default
      .reactive
      .keyboard(.willHide)
      .compactMap     { [unowned self] context -> (KeyboardChangeContext, Int)? in
        guard let index = self.handles.firstIndex(where: { $0.controller === controller }) else {
          return nil
        }
        return (context, index)
      }
      .observeValues  { [unowned self] context, index in

        let controller = self.handles[index].controller

        var newState              = self.handles[index].state
            newState.bottomOffset = 0

        self.handles[index].state = newState

        controller.view.setNeedsLayout()

        tell(UIViewPropertyAnimator(duration: context.animationDuration, curve: context.animationCurve)) {
          $0.addAnimations {
            controller.view.layoutIfNeeded()
          }
        }.startAnimation()
      }

    controller.scope += NotificationCenter
      .default
      .reactive
      .keyboard       (.willShow)
      .compactMap     { [unowned self] context -> (KeyboardChangeContext, Int)? in
        guard let index = self.handles.firstIndex(where: { $0.controller === controller }) else {
          return nil
        }
        return (context, index)
      }
      .observeValues  { [unowned self] context, index in

        let controller = self.handles[index].controller

        var newState              = self.handles[index].state
            newState.bottomOffset = context.endFrame.height

        self.handles[index].state = newState

        controller.view.setNeedsLayout()

        tell(UIViewPropertyAnimator(duration: context.animationDuration, curve: context.animationCurve)) {
          $0.addAnimations {
            controller.view.layoutIfNeeded()
          }
        }.startAnimation()
      }
  }

  func dereference<View: UIView>  (_ controller: Controller<View>) {
    handles.removeAll(where: { $0.controller === controller })
  }


  func doRootViewStuff            (for view: UIView, _ block: (State) -> Void) {
    guard let item = handles.first(where: { $0.controller.view === view }) else {
      return
    }

    block(item.state)
  }
}
