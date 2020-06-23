//
//  Scopeable.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import ReactiveSwift

/**
 Denotes a conformance to an observable scope for an object.
 */
public protocol Scopeable: class {
  var scope : ScopedDisposable<CompositeDisposable> { get }
}
