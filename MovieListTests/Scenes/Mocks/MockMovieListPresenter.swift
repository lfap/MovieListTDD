//
//  MockMovieListPresenter.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 27/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
@testable import MovieList

class MockMovieListPresenter {
    weak var outputDelegate: MovieListPresenterOutputDelegate?
    var result: Result<[MovieViewModel], Error>!
    var fetchMoviesCalled: Bool = false
}

extension MockMovieListPresenter: MovieListPresenterProtocol {
    func fetchMovies() {
        fetchMoviesCalled = true
        if case .success(let viewModels) = result {
            outputDelegate?.didFetchMoviesSuccessfully(viewModels: viewModels)
        }
    }
}
