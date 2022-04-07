//
//  MovieDetailsViewModelProtocol.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
  var movieTitle: String { get }
  var year: String { get }
  var posterImage: String { get }
  var longPlot: String { get }
  var language: String { get }
  var actors: String { get }
  var duration: String { get }

  func fetchMovieDetails(
    onCompletion: @escaping APIClientResultClosure
  )
}
