//
//  NetworkResponse.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation

struct NetworkResponse: Hashable, Decodable {
  let title       : String
  let description : String
}
