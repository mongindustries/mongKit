//
//  ViewModelResolver.swift
//  mongKit.structure
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation

public enum ModelResolutionMode {
  case singular
  case perResolution
}

extension mongKit {

  public func resolve<Model>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance) -> Model {
    resolve(for: model, on: container,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA) -> Model {
    resolve(for: model, on: container, a,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }
  
  public func resolve<Model, pA, pB>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB) -> Model {
    resolve(for: model, on: container, a, b,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }
  
  public func resolve<Model, pA, pB, pC>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC) -> Model {
    resolve(for: model, on: container, a, b, c,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD) -> Model {
    resolve(for: model, on: container, a, b, c, d,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE) -> Model {
    resolve(for: model, on: container, a, b, c, d, e,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE, pF>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE, _ f: pF) -> Model {
    resolve(for: model, on: container, a, b, c, d, e, f,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE, pF, pG>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE, _ f: pF, _ g: pG) -> Model {
    resolve(for: model, on: container, a, b, c, d, e, f, g,
            Optional<Any>.none,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE, pF, pG, pH>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE, _ f: pF, _ g: pG, _ h: pH) -> Model {
    resolve(for: model, on: container, a, b, c, d, e, f, g, h,
            Optional<Any>.none,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE, pF, pG, pH, pI>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE, _ f: pF, _ g: pG, _ h: pH, _ i: pI) -> Model {
    resolve(for: model, on: container, a, b, c, d, e, f, g, h, i,
            Optional<Any>.none)
  }

  public func resolve<Model, pA, pB, pC, pD, pE, pF, pG, pH, pI, pJ>
    (for model: Model.Type = Model.self, on container: Container = MainContainer.instance,
     _ a: pA, _ b: pB, _ c: pC, _ d: pD, _ e: pE, _ f: pF, _ g: pG, _ h: pH, _ i: pI, _ j: pJ) -> Model {
    let item = container.registeredItems[String(describing: model)]!

    switch item.resolutionMode {
    case .perResolution:
      return item.builder(a, b, c, d, e, f, g, h, i, j) as! Model
    case .singular:
      if let instance = container.staticItems[String(describing: model)] {
        return instance as! Model
      } else {
        let instance = item.builder(a, b, c, d, e, f, g, h, i ,j)
        container.staticItems[String(describing: model)] = instance
        return instance as! Model
      }
    }
  }

  public func register<Model>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping () -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (_, _, _, _, _, _, _, _, _, _) -> Any in
        return builder()
    }
  }

  public func register<Model, A>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, _, _, _, _, _, _, _, _, _) -> Any in
      let pA: A

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }

      return builder(pA)
    }
  }

  public func register<Model, A, B>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, _, _, _, _, _, _, _, _) -> Any in
      let pA: A
      let pB: B

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }

      return builder(pA, pB)
    }
  }

  public func register<Model, A, B, C>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, _, _, _, _, _, _, _) -> Any in
      let pA: A
      let pB: B
      let pC: C

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }

      return builder(pA, pB, pC)
    }
  }

  public func register<Model, A, B, C, D>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, _, _, _, _, _, _) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }

      return builder(pA, pB, pC, pD)
    }
  }
  
  public func register<Model, A, B, C, D, E>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, e, _, _, _, _, _) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D
      let pE: E

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }
      if let e = e { pE = e as? E ?? mongKit.instance.resolve(E.self) } else { pE = mongKit.instance.resolve(E.self) }

      return builder(pA, pB, pC, pD, pE)
    }
  }
  
  public func register<Model, A, B, C, D, E, F>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, e, f, _, _, _, _) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D
      let pE: E
      let pF: F

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }
      if let e = e { pE = e as? E ?? mongKit.instance.resolve(E.self) } else { pE = mongKit.instance.resolve(E.self) }
      if let f = f { pF = f as? F ?? mongKit.instance.resolve(F.self) } else { pF = mongKit.instance.resolve(F.self) }

      return builder(pA, pB, pC, pD, pE, pF)
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, e, f, g, _, _, _) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D
      let pE: E
      let pF: F
      let pG: G

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }
      if let e = e { pE = e as? E ?? mongKit.instance.resolve(E.self) } else { pE = mongKit.instance.resolve(E.self) }
      if let f = f { pF = f as? F ?? mongKit.instance.resolve(F.self) } else { pF = mongKit.instance.resolve(F.self) }
      if let g = g { pG = g as? G ?? mongKit.instance.resolve(G.self) } else { pG = mongKit.instance.resolve(G.self) }

      return builder(pA, pB, pC, pD, pE, pF, pG)
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G, H>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G, H) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, e, f, g, h, _, _) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D
      let pE: E
      let pF: F
      let pG: G
      let pH: H

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }
      if let e = e { pE = e as? E ?? mongKit.instance.resolve(E.self) } else { pE = mongKit.instance.resolve(E.self) }
      if let f = f { pF = f as? F ?? mongKit.instance.resolve(F.self) } else { pF = mongKit.instance.resolve(F.self) }
      if let g = g { pG = g as? G ?? mongKit.instance.resolve(G.self) } else { pG = mongKit.instance.resolve(G.self) }
      if let h = h { pH = h as? H ?? mongKit.instance.resolve(H.self) } else { pH = mongKit.instance.resolve(H.self) }

      return builder(pA, pB, pC, pD, pE, pF, pG, pH)
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G, H, I>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G, H, I) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, e, f, g, h, i, _) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D
      let pE: E
      let pF: F
      let pG: G
      let pH: H
      let pI: I

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }
      if let e = e { pE = e as? E ?? mongKit.instance.resolve(E.self) } else { pE = mongKit.instance.resolve(E.self) }
      if let f = f { pF = f as? F ?? mongKit.instance.resolve(F.self) } else { pF = mongKit.instance.resolve(F.self) }
      if let g = g { pG = g as? G ?? mongKit.instance.resolve(G.self) } else { pG = mongKit.instance.resolve(G.self) }
      if let h = h { pH = h as? H ?? mongKit.instance.resolve(H.self) } else { pH = mongKit.instance.resolve(H.self) }
      if let i = i { pI = i as? I ?? mongKit.instance.resolve(I.self) } else { pI = mongKit.instance.resolve(I.self) }

      return builder(pA, pB, pC, pD, pE, pF, pG, pH, pI)
    }
  }
  
  public func register<Model, A, B, C, D, E, F, G, H, I, J>
    (_ model: Model.Type, on container: Container, _ resolutionMode: ModelResolutionMode = ModelResolutionMode.singular,
     builder: @escaping (A, B, C, D, E, F, G, H, I, J) -> Model) {
    let id = String(describing: model)
    container.registeredItems[id] = InstanceInfo(id: id, resolutionMode: resolutionMode) { (a, b, c, d, e, f, g, h, i, j) -> Any in
      let pA: A
      let pB: B
      let pC: C
      let pD: D
      let pE: E
      let pF: F
      let pG: G
      let pH: H
      let pI: I
      let pJ: J

      if let a = a { pA = a as? A ?? mongKit.instance.resolve(A.self) } else { pA = mongKit.instance.resolve(A.self) }
      if let b = b { pB = b as? B ?? mongKit.instance.resolve(B.self) } else { pB = mongKit.instance.resolve(B.self) }
      if let c = c { pC = c as? C ?? mongKit.instance.resolve(C.self) } else { pC = mongKit.instance.resolve(C.self) }
      if let d = d { pD = d as? D ?? mongKit.instance.resolve(D.self) } else { pD = mongKit.instance.resolve(D.self) }
      if let e = e { pE = e as? E ?? mongKit.instance.resolve(E.self) } else { pE = mongKit.instance.resolve(E.self) }
      if let f = f { pF = f as? F ?? mongKit.instance.resolve(F.self) } else { pF = mongKit.instance.resolve(F.self) }
      if let g = g { pG = g as? G ?? mongKit.instance.resolve(G.self) } else { pG = mongKit.instance.resolve(G.self) }
      if let h = h { pH = h as? H ?? mongKit.instance.resolve(H.self) } else { pH = mongKit.instance.resolve(H.self) }
      if let i = i { pI = i as? I ?? mongKit.instance.resolve(I.self) } else { pI = mongKit.instance.resolve(I.self) }
      if let j = j { pJ = j as? J ?? mongKit.instance.resolve(J.self) } else { pJ = mongKit.instance.resolve(J.self) }

      return builder(pA, pB, pC, pD, pE, pF, pG, pH, pI, pJ)
    }
  }
}
