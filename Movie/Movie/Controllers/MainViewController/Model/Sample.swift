//
//  Sample.swift
//  Movie
//
//  Created by Louise on 2/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

struct Sample: ResponseModel, Codable {
  var id: Int?
  var authorId: Int?
  var categoryId: Int?
  var locationPlacesId: String?
}
