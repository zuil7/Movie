//
//  MovieDetailsViewModel.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
//  var onSomeCallbackEvent: VoidResult?
//
//  private(set) var someVariable1: Int = 0
//
  private let movie: Movie
  private var movieDetails: MovieDetails?

  private let service: MovieServiceProtocol
//
  init(
    model: Movie,
    service: MovieServiceProtocol = MovieService()
  ) {
    movie = model
    self.service = service
  }
}

// MARK: - Methods

extension MovieDetailsViewModel {
  func fetchMovieDetails(
    onCompletion: @escaping APIClientResultClosure
  ) {
    service.getMovieDetails(imdbId: movie.imdbID) {
      [weak self] result, status, message in
      guard let self = self, let response = result, status else { return onCompletion(false, message) }
      self.movieDetails = response
      onCompletion(status, nil)
    }
  }
}

// MARK: - Getters

extension MovieDetailsViewModel {
  var movieTitle: String { movie.title }
  var year: String { movie.year }
  var posterImage: String { movieDetails?.poster ?? "" }

  var longPlot: String { movieDetails?.plot ?? "" }
  var language: String { movieDetails?.language ?? "" }
  var actors: String { movieDetails?.actors ?? "" }
  var duration: String { movieDetails?.runtime ?? "" }
}
