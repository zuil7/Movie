//
//  MovieCellViewModelProtocol.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol MovieCellViewModelProtocol {
//  var onSomeCallbackEvent: VoidResult? { get set }

//  var someVariable1: Int { get set }
  var movieTitle: String { get }
  var year: String { get }

//
//  func someFunction1(param1: Int)
//  func someFunction2(
//    param1: Int,
//    param2: String,
//    onSuccess: @escaping VoidResult,
//    onError: @escaping ErrorResult
//  )
}
