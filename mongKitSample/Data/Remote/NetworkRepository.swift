//
//  NetworkRepository.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import ReactiveSwift

protocol NetworkRepository {
  func call() -> SignalProducer<[NetworkResponse], URLError>
}
