//
//  DisplayState.swift
//  mongKit.core
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol Stateable {
    associatedtype Payload: Hashable
    associatedtype Failure: Error & Hashable
    
    static var  load                            : Self { get }
    static func loadMore    (_ item: Payload)   -> Self
    static func successful  (_ item: Payload)   -> Self
    static func failed      (_ item: Failure)   -> Self
}

public enum DisplayState<Payload: Hashable, Failure: Error & Hashable>: Hashable, Stateable {
  
  case load
  case loadMore   (Payload)
  case successful (Payload)
  case failed     (Failure)
  
  public func hash(into hasher: inout Hasher) {
    switch self {
    case .load:
      hasher.combine(100)
    case .loadMore(let payload):
      hasher.combine(110)
      hasher.combine(payload)
    case .failed(let error):
      hasher.combine(200)
      hasher.combine(error)
    case .successful(let payload):
      hasher.combine(300)
      hasher.combine(payload)
    }
  }
}

// Weird conformance just to make this work:

extension SignalProducer where Value : Stateable, Error == Never {
  public func drive<Payload: Hashable, Failure: Swift.Error & Hashable>(
    _ preamble: @escaping (             ) -> Void,
    loading   : @escaping (             ) -> Void,
    success   : @escaping (Payload, Bool) -> Void,
    failure   : @escaping (Failure      ) -> Void) -> Disposable where Value.Payload == Payload, Value.Failure == Failure {
    observe(on: QueueScheduler.main)
      .startWithResult { result in
        switch result {
        case .success(let value):
          guard let displayState = value as? DisplayState<Payload, Failure> else {
            fatalError("Drive misuse: Specify correct Payload type of DisplayState<P, E>.")
          }

          preamble()

          switch displayState {
          case .load:
            loading()
          case .failed    (let error):
            failure(error)
          case .loadMore  (let value):
            success(value, true)
          case .successful(let value):
            success(value, false)
          }
          
        case .failure:
          fatalError()
        }
      }
  }
  
  public func filterSuccessful<Payload: Hashable, Failure: Swift.Error & Hashable>(
    payload: Payload.Type,
    failure: Failure.Type = Failure.self) -> SignalProducer<Payload, Never> {
    observe(on: QueueScheduler.main)
      .compactMap { $0 as? DisplayState<Payload, Failure> }
      .compactMap { value in
        switch value {
        case .successful(let value):
          return value
        default:
          return nil
        }
      }
  }
}
