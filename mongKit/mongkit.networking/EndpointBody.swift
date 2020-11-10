//
//  EndpointBody.swift
//  mongKit.networking
//
//  Created by Michael Ong on 10/23/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import Foundation

public protocol EndpointBody {
  var contentType : String { get }
  var payload     : Data { get }
}

public enum EndpointBodies {

  public struct JSON: EndpointBody {
    public enum Error: Swift.Error {
      case invalidData
    }
    
    public let contentType: String = "application/json"
    public var payload    : Data

    public init?<T: Encodable>(from data: T) {
      do {
        guard let data = try? JSONEncoder().encode(data) else {
          throw Error.invalidData
        }
        payload = data
      } catch {
        return nil
      }
    }
  }
  
  public struct Form: EndpointBody {
    public let contentType: String = "multipart/form-data"
    public var payload    : Data
    
    public init(payload: Data) {
      self.payload = payload
    }
  }
  
  public static var None: EndpointBody {
    __None()
  }
  
  private struct __None: EndpointBody {
    let contentType: String = ""
    let payload: Data = .init()
  }
}
