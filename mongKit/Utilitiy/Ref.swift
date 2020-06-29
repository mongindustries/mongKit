//
//  Ref.swift
//  mongKit
//
//  Created by Michael Ong on 29/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import Foundation

public struct Ref<Target> {
  let __apply: (Any) -> Void
}
