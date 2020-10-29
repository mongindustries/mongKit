//
//  Decodable+.swift
//  mongKit.networking
//
//  Created by Michael Ong on 10/23/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation

extension Decodable {
  public static func parseJson(from data: Data, response: URLResponse) throws -> Self {
    try JSONDecoder().decode(Self.self, from: data)
  }
}
