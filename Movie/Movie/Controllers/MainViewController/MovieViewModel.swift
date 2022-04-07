//
//  MovieViewModel.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

class MovieViewModel: MovieViewModelProtocol {
  var currentPage: Int = 1
  var totalResultCount: Int = 0
  var isSearching: Bool = false
  var searchKeyword: String = ""

  private let service: MovieServiceProtocol
  private var movies: [Movie] = []
  private var originalMovieList: [Movie] = []

//
  init(
    service: MovieServiceProtocol = MovieService()
  ) {
    self.service = service
  }
}

// MARK: - Methods

extension MovieViewModel {
  func movieCellVM(at index: Int) -> MovieCellViewModelProtocol {
    MovieCellViewModel(model: movies[index])
  }

  func resetSearch(thenExecute callback: @escaping VoidResult) {
    movies = originalMovieList
    callback()
  }

  func fetchMovieList(
    isReset: Bool,
    onCompletion: @escaping APIClientResultClosure
  ) {
    var filter = MovieParameters()
    filter.page = currentPage

    service.getMovieList(filter: filter) { [weak self] result, status, message in
      guard let self = self, status else { return onCompletion(false, message) }
      if isReset {
        self.movies.removeAll()
      }
      self.movies.append(contentsOf: result?.movies ?? [])
      self.totalResultCount = Int(result?.totalResults ?? "0") ?? 0
      self.originalMovieList = self.movies
      onCompletion(status, nil)
    }
  }
}

// MARK: - Getters

extension MovieViewModel {
  var rowCount: Int { movies.count }
  var movieSearchResultVM: MovieSearchResultViewModelProtocol { MovieSearchResultViewModel() }
}
