//
//  MovieDetailsController.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

class MovieDetailsController: ViewController {
  var viewModel: MovieDetailsViewModelProtocol!

  @IBOutlet private(set) var posterImage: UIImageView!
  @IBOutlet private(set) var titleLabel: UILabel!
  @IBOutlet private(set) var yearDurationLabel: UILabel!
  @IBOutlet private(set) var languageLabel: UILabel!
  @IBOutlet private(set) var actorsLabel: UILabel!
  @IBOutlet private(set) var plot: UILabel!

  // private(set) var fieldInputController: MDCInputControllerBase!
}

// MARK: - Lifecycle

extension MovieDetailsController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }
}

// MARK: - Setup

private extension MovieDetailsController {
  func setup() {
    setupNavigation()
    getMovieDetails()
  }

  func setupNavigation() {
    navigationItem.title = S.movieDetailsTitle()
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.customizeNavBar(barColor: .black, textColor: .white)
  }

  func getMovieDetails() {
    showHud()
    viewModel.fetchMovieDetails(onCompletion: handleGetMovieDetailsSuccess())
  }
}

// MARK: - Bindings

private extension MovieDetailsController {
  func bind() {
  }
}

// MARK: - Event Handlers

private extension MovieDetailsController {
  func handleGetMovieDetailsSuccess() -> APIClientResultClosure {
    return { [weak self] status, message in
      guard let self = self else { return }
      self.dismissHud()
      if status {
        self.populateDetails()
      } else {
        self.showAlert(
          title: S.errorTitle(),
          message: message ?? S.errorGenericTitle()
        )
      }
    }
  }
}

// MARK: - Helpers

private extension MovieDetailsController {
  func populateDetails() {
    posterImage.setImageWithURL(URL(string: viewModel.posterImage))
    titleLabel.text = viewModel.movieTitle

    let yearDuration = "\(S.yearTitle()) \(viewModel.year) \(S.durationTitle()) \(viewModel.duration)"
      .addTextAttribute(
        keyWords: [S.yearTitle(), S.durationTitle()],
        withTextColor: .green,
        withFont: .systemFont(ofSize: 15.0, weight: .bold)
      )
    yearDurationLabel.attributedText = yearDuration

    actorsLabel.text = viewModel.actors

    languageLabel.attributedText = "\(S.languageTitle()) \(viewModel.language)"
      .addTextAttribute(
        keyWords: [S.languageTitle()],
        withTextColor: .green,
        withFont: .systemFont(ofSize: 15.0, weight: .bold)
      )
    plot.attributedText = "\(S.plotTitle()) \(viewModel.longPlot)"
      .addTextAttribute(
        keyWords: [S.plotTitle()],
        withTextColor: .green,
        withFont: .systemFont(ofSize: 15.0, weight: .bold)
      )
  }
}
