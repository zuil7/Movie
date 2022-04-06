//
//  ResponseModel.swift
//  Movie
//
//  Created by Louise on 2/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

// MARK: - APIModel

protocol ResponseModel: Model {}

extension ResponseModel {
  static func decoder() -> JSONDecoder {
    // You can set your preferred decoding strategies here.
    let d = JSONDecoder()
    d.dateDecodingStrategy = .formatted(.iso8601Full)
    d.keyDecodingStrategy = .convertFromSnakeCase
    return d
  }

  static func encoder() -> JSONEncoder {
    // You can set your preferred encoding strategies here.
    let e = JSONEncoder()
    e.dateEncodingStrategy = .formatted(.iso8601Full)
    e.keyEncodingStrategy = .convertToSnakeCase
    return e
  }
}
