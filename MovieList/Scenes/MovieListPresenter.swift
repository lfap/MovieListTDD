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
        worker.fetchMovies { _ in
            
        }
    }
}
