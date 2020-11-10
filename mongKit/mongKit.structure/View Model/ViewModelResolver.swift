//
//  ViewModelResolver.swift
//  mongKit.structure
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation
import mongKitCore

public enum ModelResolutionMode {
  case singular
  case perResolution
}

extension mongKit {

  public func resolve<Model>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance) -> Model {
    resolve(for: model, on: container, Optional<Any>.none, Optional<Any>.none, Optional<Any>.none, Optional<Any>.none, Optional<Any>.none)
  }

  public func resolve<Model, pA>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA) -> Model {
    resolve(for: model, on: container, a, Optional<Any>.none, Optional<Any>.none, Optional<Any>.none, Optional<Any>.none)
  }
  
  public func resolve<Model, pA, pB>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB) -> Model {
    resolve(for: model, on: container, a, b, Optional<Any>.none, Optional<Any>.none, Optional<Any>.none)
  }
  
  public func resolve<Model, pA, pB, pC>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC) -> Model {
    resolve(for: model, on: container, a, b, c, Optional<Any>.none, Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD) -> Model {
    resolve(for: model, on: container, a, b, c, d, Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE) -> Model {
    let item = container.registeredItems[String(describing: model)]!

    switch item.resolutionMode {
    case .perResolution:
      return item.builder(a, b, c, d, e) as! Model
    case .singular:
      if let instance = container.staticItems[String(describing: model)] {
        return instance as! Model
      } else {
        let instance = item.builder(a, b, c, d, e)
        container.staticItems[String(describing: model)] = instance
        return instance as! Model
      }
    }
  }

  public func register<Model>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping () -> Model) {
    container.registeredItems[String(describing: model)] = InstanceInfo(
      id            : String(describing: model),
      resolutionMode: resolutionMode,
      builder       : { _, _, _, _, _ in builder() }) // TODO: complete this
  }

  public func register<Model, A>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container))
    }
  }

  public func register<Model, A, B>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }

  public func register<Model, A, B, C>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }

  public func register<Model, A, B, C, D>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
  
  public func register<Model, A, B, C, D, E>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
  
  public func register<Model, A, B, C, D, E, F>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G, H>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G, H) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G, H, I>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G, H, I) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G, H, I, J>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G, H, I, J) -> Model) {
    register(model, on: container, resolutionMode) {
      builder(mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container),
              mongKit.instance.resolve(on: container))
    }
  }
}
