//
//  MovieSearchResultViewModelProtocol.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MovieSearchResultViewModelProtocol {
  var onRefreshSearch: VoidResult? { get set }
  var onSelectSearchItem: SingleResult<Movie>? { get set }

  var currentPage: Int { get set }
  var totalResultCount: Int { get set }
  var searchKeyword: String { get set }

  var rowCount: Int { get }

  func setSelectedMovie(at index: Int)
  func onKeywordType(text: String)
  func movieCellVM(at index: Int) -> MovieCellViewModelProtocol
  func searchMovies(
    isTypying: Bool,
    onCompletion: @escaping APIClientResultClosure
  )
}
