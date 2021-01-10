//
// Created by Michael Ong on 10/23/20.
// Copyright (c) 2020 mong Industries. All rights reserved.
//
import Foundation
import ReactiveSwift

public protocol Endpoint {
  var path  : URL             { get }

  var body  : EndpointBody    { get }
  var method: EndpointMethod  { get }
}

extension Endpoint {
  public func performRequest
  (with session : URLSession = EndpointManager.instance.session,
   _  config    : (inout URLRequest) -> Void = { _ in }) -> SignalProducer<(Data, URLResponse), URLError>  {
      session
        .reactive
        .data     (with: tell(URLRequest(url: path)) {
          $0.httpMethod = method.rawValue
          $0.httpBody   = body.payload

          if !body.contentType.isEmpty {
            $0.addValue(body.contentType, forHTTPHeaderField: "Content-Type")
          }

          config(&$0)

            #if DEBUG
            print("URL: [\($0.httpMethod!)] \($0.url!)")
            print("Header:")
            $0.allHTTPHeaderFields?.forEach { key, value in
                print("\(key): \(value)")
            }
            #endif
        })
        .mapError { $0 as! URLError }
    }
}
