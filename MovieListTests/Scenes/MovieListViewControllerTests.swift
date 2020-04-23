//
//  MovieListViewControllerTests.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
import UIKit
@testable import MovieList

class MovieListViewControllerTests: XCTestCase {
    
    var sut: MovieListViewController!
    
    override func setUp() {
        sut = MovieListViewController()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMovieListViewController_isLoaded() {
        XCTAssertNotNil(sut)
    }
    
    func testMovieListViewController_conformsWithMovieListPresenterOutputDelegate() {
        // Arrange
        let sutProtocol = sut as AnyObject
        
        // Assert
        XCTAssertTrue(sutProtocol is MovieListPresenterOutputDelegate)
    }
}
