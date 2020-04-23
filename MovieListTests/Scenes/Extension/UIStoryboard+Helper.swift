//
//  UIStoryboard+Helper.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
@testable import MovieList

func loadMovieListViewController() -> MovieListViewController {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    guard let movieListViewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
        fatalError("The Root view Controller isn't the MovieListViewController")
    }
    return movieListViewController
}

