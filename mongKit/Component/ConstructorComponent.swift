//
//  ConstructorComponent.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct ConstructorComponent: Component {

  let style     : Style
  let layout    : LayoutConfiguration

  let children  : () -> Component
}
