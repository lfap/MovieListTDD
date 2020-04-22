//
//  MovieListPresenter.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class MovieListPresenter {
    private let worker: MovieListWorkerProtocol
    weak var outputDelegate: MovieListPresenterOutputDelegate?
    
    init(worker: MovieListWorkerProtocol = MovieListWorker()) {
        self.worker = worker
    }
}

extension MovieListPresenter: MovieListPresenterProtocol {
    func fetchMovies() {
        worker.fetchMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                let viewModels = self.parseMoviesToViewModels(movies)
                self.outputDelegate?.didFetchMoviesSuccessfully(viewModels: viewModels)
            case .failure(let error):
                self.outputDelegate?.didFetchMovies(withErrorMessage: error.presentableMessage)
            }
        }
    }
    
    private func parseMoviesToViewModels(_ movies: [Movie]) -> [MovieViewModel] {
        movies.map(MovieViewModel.init)
    }
}
