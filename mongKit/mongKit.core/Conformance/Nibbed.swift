//
//  Nibbed.swift
//  mongKit.core
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import UIKit

public protocol Nibbed {
  static var nib: UINib { get }
}

extension Nibbed {
  public static var nib: UINib { UINib(nibName: String(describing: Self.self), bundle: nil) }
}
