//
//  MovieViewModelProtocol.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MovieViewModelProtocol {
  var onSelectMovie: VoidResult? { get set }

  var currentPage: Int { get set }
  var totalResultCount: Int { get set }
  var isSearching: Bool { get set }
  var searchKeyword: String { get set }

  var rowCount: Int { get }
  var movieSearchResultVM: MovieSearchResultViewModelProtocol { get }
  var movieDetailsVM: MovieDetailsViewModelProtocol? { get }

  func movieCellVM(at index: Int) -> MovieCellViewModelProtocol
  func resetSearch(thenExecute callback: @escaping VoidResult)
  func setSelectedMovie(at index: Int)
  func setSelectedFromSearch(item: Movie)

  func fetchMovieList(
    isReset: Bool,
    onCompletion: @escaping APIClientResultClosure
  )
}
