//
//  MovieParameters.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

struct MovieParameters {
  var type: String? = "movie"
  var s: String? = "all"
  var page: Int?
}

extension MovieParameters {
  var parameters: Parameters {
    var params: Parameters = [:]

    if let type = type {
      params["type"] = type
    }

    if let s = s {
      params["s"] = s
    }

    if let page = page {
      params["page"] = page
    }

    return params
  }
}
