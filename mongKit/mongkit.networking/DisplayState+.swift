//
//  DisplayState+.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import mongKitCore
import ReactiveSwift

extension SignalProducer where Value: Hashable, Error: Hashable {
  public var displayState: SignalProducer<DisplayState<Value, Error>, Never> {
    SignalProducer<DisplayState<Value, Error>, Never> { send, life in
      send.send(value: .load)

      let bag = self
        .observe          (on: QueueScheduler.main)
        .startWithResult  { result in
          switch result {
          case .failure(let error):
            send.send(value: .failed(error))
          case .success(let pload):
            send.send(value: .successful(pload))
            send.sendCompleted()
          }
        }

      life.observeEnded {
        bag.dispose()
      }
    }
  }
}
