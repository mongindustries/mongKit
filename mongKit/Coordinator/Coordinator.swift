//
//  Coordinator.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol AnyCoordinator: class {
  var parent: AnyCoordinator? { get }

  func unwind(_ next: @escaping () -> Void)
}

public protocol Coordinator: AnyCoordinator {
  associatedtype Container: UIViewController

  func setup() -> Container
}

public protocol ForwardingCoordinator: AnyCoordinator {
  associatedtype Container: UIViewController

  associatedtype Success
  associatedtype Failure: Error

  func setup(continuation: @escaping (Result<Success, Failure>) -> Void) -> Container
}
