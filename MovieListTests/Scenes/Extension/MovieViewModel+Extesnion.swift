//
//  MovieViewModel+Extesnion.swift
//  MovieListTDDTests
//
//  Created by Luiz F. A. Pio on 13/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

@testable import MovieList

extension MovieViewModel {
    static var viewModels: [MovieViewModel] = Movie.movies.map(MovieViewModel.init)
}
