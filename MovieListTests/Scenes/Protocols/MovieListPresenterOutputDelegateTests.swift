//
//  MovieListPresenterOutputDelegateTests.swift
//  MovieListTDDTests
//
//  Created by Luiz F. A. Pio on 13/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieListPresenterOutputDelegateTests: XCTestCase {
    
    var sut: MovieListPresenterOutputDelegate!
    
    override func setUp() {
        sut = MovieListPresenterTests.SpyViewController()
    }
    
    override func tearDown() {
        sut = nil
    }
        
    func testMovieListPresenterOutputDelegate_delcaresDidFetchMoviesSuccessfully() {
        sut.didFetchMoviesSuccessfully(viewModels: [])
    }
    
    func testMovieListPresenterOutputDelegate_declaresDidFetchMoviesWithError() {
        sut.didFetchMovies(withErrorMessage: "")
    }
}
