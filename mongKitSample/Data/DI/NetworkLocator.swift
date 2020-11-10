//
//  NetworkLocator.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/8/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation
import mongKitCore
import mongKitStructure

func networkLocator() {
  mongKit.instance.register(NetworkRepository.self,
                            on: MainContainer.instance, builder: NetworkRepositoryReal.init)
  mongKit.instance.register(NetworkCall.self,
                            on: MainContainer.instance, builder: NetworkCall.init)

  mongKit.instance.register(NetworkBinding.self,
                            on: MainContainer.instance, .perResolution, builder: NetworkBindingReal.init)
}
