//
//  NetworkBinding.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore
import ReactiveSwift

protocol NetworkBinding {
  var items: Property<DisplayState<[NetworkResponse], URLError>> { get }
}

struct NetworkBindingReal: NetworkBinding {

  var items: Property<DisplayState<[NetworkResponse], URLError>>
  
  init(networkCall: NetworkCall) {
    items  = Property(
      initial : .load,
      then    : networkCall().mapError { err in fatalError(err.localizedDescription) }.displayState)
  }
}
