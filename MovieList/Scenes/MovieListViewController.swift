//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieListViewController: MovieListPresenterOutputDelegate {
    func didFetchMoviesSuccessfully(viewModels: [MovieViewModel]) {
    }
    
    func didFetchMovies(withErrorMessage errorMessage: String) {
    }    
}
