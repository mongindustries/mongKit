//
//  EndpointManager.swift
//  mongKit.networking
//
//  Created by Michael Ong on 10/23/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation
import mongKitCore

public class EndpointManager {
  public static let instance = EndpointManager()

  public var session = URLSession(configuration: .default)
}
