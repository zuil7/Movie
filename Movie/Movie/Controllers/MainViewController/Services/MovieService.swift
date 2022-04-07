//
//  MovieService.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

class MovieService: BaseService, MovieServiceProtocol {
}

// MARK: - Methods

extension MovieService {
  func getMovieList(
    filter: MovieParameters?,
    completion: @escaping ResultClosure<MovieResponse>
  ) {
    let url = movieListEP

    var params = Parameters()

    if let filter = filter {
      params = params.merging(filter.parameters) { $1 }
    }
      
    consumeAPI(
      MovieResponse.self,
      endPoint: url,
      verb: .GET,
      parameters: params,
      completion: { result, error in
        guard error == nil else {
          return completion(nil, false, error?.localizedDescription)
        }
        completion(result, true, nil)
      }
    )
  }
}
