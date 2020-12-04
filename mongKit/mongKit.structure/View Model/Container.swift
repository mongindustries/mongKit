//
//  Container.swift
//  mongKit.structure
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation

public struct InstanceInfo {
  let id              : String
  let resolutionMode  : ModelResolutionMode

  let builder         : (Any?, Any?, Any?, Any?, Any?, Any?, Any?, Any?, Any?, Any?) -> Any
}

public protocol Container: class {
  var staticItems     : [ AnyHashable : Any ] { get set }
  var registeredItems : [ AnyHashable : InstanceInfo ] { get set }
}

public class MainContainer: Container {
  public static var instance = MainContainer()

  public var staticItems      : [AnyHashable : Any ]          = [ : ]
  public var registeredItems  : [AnyHashable : InstanceInfo ] = [ : ]
}
