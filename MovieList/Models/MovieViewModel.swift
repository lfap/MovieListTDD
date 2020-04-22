//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class MovieViewModel {
    let title: String
    
    init(movie: Movie) {
        title = "\(movie.name) (\(movie.year))"
    }
}

extension MovieViewModel: Equatable {
    static func ==(lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        lhs.title == rhs.title
    }
}
