//
//  MovieController.swift
//  Movie
//
//  Created by Louise on 4/6/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

class MovieController: ViewController {
  var viewModel: MovieViewModelProtocol = MovieViewModel()

  @IBOutlet private(set) var tableView: UITableView!
  private var movieSearchResultController: MovieSearchResultController!

  private var disposeBag = DisposeBag()
}

// MARK: - Lifecycle

extension MovieController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }
}

// MARK: - Setup

private extension MovieController {
  func setup() {
    setupTitle()
    setupSearchController()
    setupTableView()
    fetchMovie(isReset: true)
  }

  func setupTitle() {
    title = "Movies"
  }

  func setupSearchController() {
    movieSearchResultController = R.storyboard.main.movieSearchResultController()!
    movieSearchResultController.viewModel = viewModel.movieSearchResultVM
    let searchController = UISearchController(searchResultsController: movieSearchResultController)
    navigationItem.searchController = searchController
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.delegate = self // Monitor when the search button is tapped.
  }

  func setupTableView() {
    tableView.register(R.nib.movieCell)
  }

  func fetchMovie(isReset: Bool = false) {
    if isReset {
      showHud()
    }
    viewModel.fetchMovieList(
      isReset: isReset,
      onCompletion: handleGetMovieSuccess()
    )
  }

//  func searchMovie() {
//    viewModel.searchMovies(
//      onCompletion: handleGetMovieSuccess()
//    )
//  }
}

// MARK: - Bindings

private extension MovieController {
  func bind() {
//    searchTextField.rx.text
//      .subscribe(onNext: handleSearchTextChange())
//      .disposed(by: disposeBag)
  }
}

// MARK: - Router

private extension MovieController {
//  func presentSomeController() {
//    let vc = R.storyboard.someController.SomeController()!
//    vc.viewModel = SomeViewModel()
//    navigationController?.pushViewController(vc, animated: true)
//  }
}

// MARK: - Actions

private extension MovieController {
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

private extension MovieController {
  func handleGetMovieSuccess() -> APIClientResultClosure {
    return { [weak self] status, message in
      guard let self = self else { return }
      self.dismissHud()
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

private extension MovieController {
  func refreshTableView() {
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource

extension MovieController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    cell.selectionStyle = .none

    let isLastIndex = (indexPath.row == viewModel.rowCount - 1)

    if isLastIndex && (viewModel.rowCount < viewModel.totalResultCount) {
      viewModel.currentPage += 1
      fetchMovie()
    }
  }

  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.rowCount
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: R.reuseIdentifier.movieCell,
        for: indexPath
      )
    else {
      preconditionFailure("Expected cell of type movieCell")
    }

    cell.viewModel = viewModel.movieCellVM(at: indexPath.row)
    return cell
  }

  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
  }
}

extension MovieController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let keyword = searchController.searchBar.text,
          !keyword.isEmpty
    else { return }
    movieSearchResultController.viewModel.onKeywordType(text: keyword)
  }
}

// MARK: - UISearchBarDelegate

extension MovieController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }

  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    updateSearchResults(for: searchController)
  }
}

// MARK: - UISearchControllerDelegate

extension MovieController: UISearchControllerDelegate {
  func presentSearchController(_ searchController: UISearchController) {
    // Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }

  func willPresentSearchController(_ searchController: UISearchController) {
    // Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }

  func didPresentSearchController(_ searchController: UISearchController) {
    // Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }

  func willDismissSearchController(_ searchController: UISearchController) {
    // Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }

  func didDismissSearchController(_ searchController: UISearchController) {
    // Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
  }
}
