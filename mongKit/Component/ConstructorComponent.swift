//
//  ConstructorComponent.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct ConstructorComponent: Component {

  let style     : Style
  let layout    : Layout

  let children  : () -> Component
}
