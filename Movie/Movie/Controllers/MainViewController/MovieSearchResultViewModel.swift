//
//  MovieSearchResultViewModel.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

class MovieSearchResultViewModel: MovieSearchResultViewModelProtocol {
  var onRefreshSearch: VoidResult?
  var onSelectSearchItem: SingleResult<Movie>?

  var currentPage: Int = 1
  var totalResultCount: Int = 0
  var searchKeyword: String = ""
  private var selectedMovie: Movie?

  private let service: MovieServiceProtocol
  private var movies: [Movie] = []

  init(
    service: MovieServiceProtocol = MovieService()
  ) {
    self.service = service
  }
}

// MARK: - Methods

extension MovieSearchResultViewModel {
  func setSelectedMovie(at index: Int) {
    selectedMovie = movies[index]
    guard let movie = selectedMovie else { return }
    onSelectSearchItem?(movie)
  }

  func onKeywordType(text: String) {
    guard text.count > 3 else { return }
    debugPrint(text)
    searchKeyword = text
    onRefreshSearch?()
  }

  func movieCellVM(at index: Int) -> MovieCellViewModelProtocol {
    MovieCellViewModel(model: movies[index])
  }

  func searchMovies(
    isTypying: Bool,
    onCompletion: @escaping APIClientResultClosure
  ) {
    if isTypying {
      movies.removeAll()
      currentPage = 1
    }
    var filter = MovieParameters()
    filter.page = currentPage
    filter.s = searchKeyword

    service.getMovieList(filter: filter) { [weak self] result, status, message in
      guard let self = self, status else { return onCompletion(false, message) }

      self.movies.append(contentsOf: result?.movies ?? [])
      self.totalResultCount = Int(result?.totalResults ?? "0") ?? 0
      onCompletion(status, nil)
    }
  }
}

// MARK: - Getters

extension MovieSearchResultViewModel {
  var rowCount: Int { movies.count }
}
