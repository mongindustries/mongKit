//
//  CodedView.swift
//  mongKit
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

/**
 Conformance for identifying a class-type that holds a body prop type for view construction.
 */
public protocol CodedView: class {
  /// The handle for generating the view hiearchy.
  var body: Component { get }
}
