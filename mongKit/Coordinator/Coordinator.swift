//
//  Coordinator.swift
//  mongKit
//
//  Created by rantingmong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public protocol AnyCoordinator {
  var parent: AnyCoordinator? { get }

  init(parent: AnyCoordinator?)

  func unwind(_ next: () -> Void)
}

public protocol Coordinator: AnyCoordinator {
  associatedtype Container: UIViewController

  var container: Container { get }
}
