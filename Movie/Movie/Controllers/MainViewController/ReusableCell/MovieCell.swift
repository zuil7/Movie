//
//  MovieCell.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

class MovieCell: UITableViewCell {
  var viewModel: MovieCellViewModelProtocol! {
    didSet {
      bind()
      refresh()
    }
  }

  @IBOutlet private(set) var movieTitleLabel: UILabel!
  @IBOutlet private(set) var yearLabel: UILabel!

  private var disposeBag = DisposeBag()

  override func awakeFromNib() {
    setup()
  }
}

// MARK: - Setup

private extension MovieCell {
  func setup() {
  }
}

// MARK: - Bindings

private extension MovieCell {
  func bind() {
    disposeBag = DisposeBag()
    guard viewModel != nil else { return }
    movieTitleLabel.text = viewModel.movieTitle
    yearLabel.text = viewModel.year
  }
}

// MARK: - Refresh

private extension MovieCell {
  func refresh() {
    guard viewModel != nil else { return }
  }
}

// MARK: - Helpers

private extension MovieCell {
}
