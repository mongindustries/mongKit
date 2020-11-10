//
//  NetworkController.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import UIKit
import mongKitCore
import mongKitView
import mongKitStructure
import mongKitNetworking

import ReactiveSwift

class NetworkController: Controller<NetworkView> {

  lazy var binding: NetworkBinding = { mongKit.instance.resolve() }()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Network"

    scope += rootView.$items <~ binding.items
  }
}
