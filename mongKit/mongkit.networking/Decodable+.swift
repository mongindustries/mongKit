//
//  Decodable+.swift
//  mongKit.networking
//
//  Created by Michael Ong on 10/23/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation

extension Decodable {
  public static func parseJson(from data: Data, response: URLResponse) -> Result<Self, URLError> {
    do {
      return Result.success(try JSONDecoder().decode(Self.self, from: data))
    } catch let item as DecodingError {
      return Result.failure(URLError(URLError.cannotDecodeRawData, userInfo: [ "cause" : item ]))
    } catch {
      return Result.failure(URLError(URLError.cannotDecodeRawData))
    }
  }
}
