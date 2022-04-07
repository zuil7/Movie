//
//  MovieSearchResultController.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

class MovieSearchResultController: UITableViewController {
  var viewModel: MovieSearchResultViewModelProtocol!

  // @IBOutlet private(set) var label: UILabel!
  // @IBOutlet private(set) var field: APTextField!

  // private(set) var fieldInputController: MDCInputControllerBase!
}

// MARK: - Lifecycle

extension MovieSearchResultController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }
}

// MARK: - Setup

private extension MovieSearchResultController {
  func setup() {
    setupTiggers()
    setupTableView()
  }

  func setupTableView() {
    tableView.register(R.nib.movieCell)
  }

  func setupTiggers() {
    viewModel.onRefreshSearch = trigger(type(of: self).searchMovie)
  }
}

// MARK: - Bindings

private extension MovieSearchResultController {
  func bind() {
  }
}

// MARK: - Router

private extension MovieSearchResultController {
//  func presentSomeController() {
//    let vc = R.storyboard.someController.SomeController()!
//    vc.viewModel = SomeViewModel()
//    navigationController?.pushViewController(vc, animated: true)
//  }
}

// MARK: - Actions

private extension MovieSearchResultController {
//  @IBAction
//  func someButtonTapped(_ sender: Any) {
//    viewModel.someFunction2(
//      param1: 0,
//      param2: "",
//      onSuccess: handleSomeSuccess(),
//      onError: handleError()
//    )
//  }
}

// MARK: - Event Handlers

private extension MovieSearchResultController {
  func handleSearchMovieSuccess() -> APIClientResultClosure {
    return { [weak self] status, message in
      guard let self = self else { return }
      if status {
        self.refreshTableView()
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

private extension MovieSearchResultController {
  func searchMovie() {
    viewModel.searchMovies(
      isTypying: true,
      onCompletion: handleSearchMovieSuccess()
    )
  }

  func refreshTableView() {
    tableView.reloadData()
  }

  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok", style: .default) { _ in }
    alertController.addAction(ok)
    present(alertController, animated: true, completion: nil)
  }
}

// MARK: - SomeControllerProtocol

// extension MovieSearchResultController: SomeControllerProtocol {
//
// }

// MARK: - UITableViewDataSource

extension MovieSearchResultController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.rowCount
  }

  override func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    cell.selectionStyle = .none

    let isLastIndex = (indexPath.row == viewModel.rowCount - 1)

    if isLastIndex && (viewModel.rowCount < viewModel.totalResultCount) {
      viewModel.currentPage += 1
      viewModel.searchMovies(
        isTypying: false,
        onCompletion: handleSearchMovieSuccess()
      )
    }
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: R.reuseIdentifier.movieCell,
      for: indexPath
    ) else { return UITableViewCell() }

    cell.viewModel = viewModel.movieCellVM(at: indexPath.row)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
}
