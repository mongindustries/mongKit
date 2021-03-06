//
//  Scopeable.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import ReactiveSwift

/**
 Denotes a conformance to an observable scope for an object.
 */
public protocol Scopeable: class {
  /// The handle for scoping reactive lifetimes.
  var scope : ScopedDisposable<CompositeDisposable> { get }
}
