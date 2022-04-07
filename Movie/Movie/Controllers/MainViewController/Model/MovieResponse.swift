//
//  Movie.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
  let movies: [Movie]?
  let totalResults: String?
  let error: String?
  let response: String

  enum CodingKeys: String, CodingKey {
    case movies = "Search"
    case totalResults
    case response = "Response"
    case error = "Error"
  }
}

// MARK: - Movie

struct Movie: Codable {
  let title: String
  let year: String
  let imdbID: String
  let type: TypeEnum
  let poster: String

  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
    case imdbID
    case type = "Type"
    case poster = "Poster"
  }
}

enum TypeEnum: String, Codable {
  case movie
}
