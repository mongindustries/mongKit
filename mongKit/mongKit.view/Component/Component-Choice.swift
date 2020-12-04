//
//  ChoiceComponent.swift
//  mongKit
//
//  Created by Michael Ong on 7/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

public protocol ChoiceResolverComponent {

  var result: Component { get }
}

extension Components {
  
  public enum Choice<TC: Component, FC: Component>: Component, ChoiceResolverComponent {
    case shi(TC)
    case fei(FC)

    public var result: Component {
      switch self {
      case .fei(let c):
        return c
      case .shi(let c):
        return c
      }
    }
  }
}
