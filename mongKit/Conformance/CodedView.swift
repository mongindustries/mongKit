//
//  CodedView.swift
//  mongKit
//
//  Created by Michael Ong on 24/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

public protocol CodedView: class {

  var body: Component { get }
}
