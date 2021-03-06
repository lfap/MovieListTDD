//
//  MovieListPresenterOutputDelegate.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

protocol MovieListPresenterOutputDelegate: AnyObject {
    func didFetchMoviesSuccessfully(viewModels: [MovieViewModel])
    func didFetchMovies(withErrorMessage errorMessage: String)
}
