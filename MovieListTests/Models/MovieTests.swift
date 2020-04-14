//
//  MovieTests.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 08/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieTests: XCTestCase {
    
    var sut: Movie!
    
    override func setUp() {
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testMovie_initializerWithNameAndYear() {
        // Arrange
        let name: String = "The Fast and The Furious"
        let year: Int = 2001
        
        // Act
        sut = Movie(name: name, year: year)
        
        // Assert
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.name, name)
        XCTAssertEqual(sut.year, year)
    }
}
