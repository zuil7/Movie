//
//  MovieServiceProtocol.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
  func getMovieList(
    filter: MovieParameters?,
    completion: @escaping ResultClosure<MovieResponse>
  )

  func getMovieDetails(
    imdbId: String,
    completion: @escaping ResultClosure<MovieDetails>
  )
}
