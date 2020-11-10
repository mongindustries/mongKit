//
//  NetworkEndpoint.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation
import mongKitCore
import mongKitNetworking

enum NetworkEndpoint: mongKitNetworking.Endpoint {
  var path: URL {
    switch self {
    case .call:
      return URL(string: "https://run.mocky.io/v3/e21cd3ea-7962-41db-bb30-6a0e2af56bc6?mocky-delay=2sec")!
    }
  }

  var body  : EndpointBody    { EndpointBodies.None }
  var method: EndpointMethod  { .GET }

  case call
}
