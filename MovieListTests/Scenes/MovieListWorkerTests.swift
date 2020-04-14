//
//  MovieListWorkerTests.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 08/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieListWorkerTests: XCTestCase {
    
    var sut: MovieListWorker!
    var connector: Connector!
    
    override func setUp() {
        connector = Connector(provider: MockURLSession())
        sut = MovieListWorker(connector: connector)
    }
    
    override func tearDown() {
        sut = nil
        connector = nil
    }
    
    func testMovieListWorker_initilizer() {
        XCTAssertNotNil(sut)
    }
    
    func testMovieListWorker_declaresFetchMovies_returnDataTask() {
        // Act
        let dataTask = sut.fetchMovies { _ in }
        
        // Assert
        XCTAssertTrue(dataTask is MockURLSessionDataTask)
    }
    
    func testMovieListWorker_fetchMovies_completesWithResultType() {
        // Arrange
        typealias expectedType = Result<[Movie], MovieListWorker.WorkerError>
        var receivedResult: Any!
    
        // Act
        let dataTask = sut.fetchMovies { result in
            receivedResult = result
        } as! MockURLSessionDataTask
        dataTask.completion(nil, nil, nil)
        
        // Assert
        XCTAssertTrue(receivedResult is expectedType)
    }
    
}
