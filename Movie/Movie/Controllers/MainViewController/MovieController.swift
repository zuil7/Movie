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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupTitle()
  }
}

// MARK: - Setup

private extension MovieController {
  func setup() {
    setupTiggers()
    setupSearchController()
    setupTableView()
    fetchMovie(isReset: true)
  }

  func setupTitle() {
    navigationItem.title = S.moviesTitle()

    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithOpaqueBackground()
    navigationBarAppearance.backgroundColor = .black
    navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.red]
    navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    navigationController?.navigationBar.compactAppearance = navigationBarAppearance
    navigationController?.navigationBar.standardAppearance = navigationBarAppearance
  }

  func setupTiggers() {
    viewModel.onSelectMovie = trigger(type(of: self).selectedMovie)
  }

  func setupSearchController() {
    movieSearchResultController = R.storyboard.main.movieSearchResultController()!
    movieSearchResultController.viewModel = viewModel.movieSearchResultVM
    movieSearchResultController.onTappedSearchItem = handleSearchItemTapped()
    let searchController = UISearchController(searchResultsController: movieSearchResultController)

    searchController.searchBar.searchTextField.backgroundColor = .white
    searchController.searchBar.searchTextField.tintColor = .black

    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
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
}

// MARK: - Router

private extension MovieController {
  func navigateToMovieDetails() {
    let vc = R.storyboard.main.movieDetailsController()!
    vc.viewModel = viewModel.movieDetailsVM
    navigationController?.pushViewController(vc, animated: true)
  }
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

  func handleSearchItemTapped() -> SingleResult<Movie> {
    return { [weak self] movie in
      guard let self = self else { return }
      self.viewModel.setSelectedFromSearch(item: movie)
    }
  }
}

// MARK: - Helpers

private extension MovieController {
  func refreshTableView() {
    tableView.reloadData()
  }

  func selectedMovie() {
    navigateToMovieDetails()
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
    viewModel.setSelectedMovie(at: indexPath.row)
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
