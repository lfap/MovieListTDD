//
//  MovieViewModelTests.swift
//  MovieListTDDTests
//
//  Created by Luiz F. A. Pio on 13/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieViewModelTests: XCTestCase {

    var sut: MovieViewModel!

    func testMovieViewModel_initializeWithMovie() {
        // Arrange
        let movie = Movie(name: "The Fast and The Fuirous", year: 2001)
        let expectedTitle: String = "The Fast and The Fuirous (2001)"
        
        // Act
        sut = MovieViewModel(movie: movie)
        
        // Assert
        XCTAssertEqual(sut.title, expectedTitle)
    }
}
