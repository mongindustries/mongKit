//
//  NetworkCall.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import ReactiveSwift

struct NetworkCall {
  let repository: NetworkRepository
  
  func callAsFunction() -> SignalProducer<[NetworkResponse], URLError> {
    repository.call()
  }
}
