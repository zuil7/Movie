//
//  MovieCellViewModel.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

class MovieCellViewModel: MovieCellViewModelProtocol {
//  var onSomeCallbackEvent: VoidResult?
//
//  private(set) var someVariable1: Int = 0
//
  private let movie: Movie
//  private let service: SomeService
//
  init(
    model: Movie
  ) {
    movie = model
  }
}

// MARK: - Methods

extension MovieCellViewModel {
//  func someFunction1(param1: Int) {
//
//  }
//
//  func someFunction2(
//    param1: Int,
//    param2: String,
//    onSuccess: @escaping VoidResult,
//    onError: @escaping ErrorResult
//  ) {
//
//  }
}

// MARK: - Getters

extension MovieCellViewModel {
    var movieTitle: String { movie.title }
    var year: String { movie.year }
}
