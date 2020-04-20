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
        connector = Connector(provider: DelayedMockURLSession())
        sut = MovieListWorker(connector: connector)
    }
    
    override func tearDown() {
        sut = nil
        connector = nil
    }
    
    // MARK: - Helpers
    private func parseMovies(_ data: Data) -> [Movie] {
        let jsonDecoder = JSONDecoder()
        let movies = try! jsonDecoder.decode([Movie].self, from: data)
        return movies
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
        let exp = expectation(description: "Expect to fetch movies")
    
        // Act
        let dataTask = sut.fetchMovies { result in
            receivedResult = result
            exp.fulfill()
        } as! MockURLSessionDataTask
        dataTask.completion(nil, nil, nil)
        
        // Assert
        wait(for: [exp], timeout: 0.2)
        XCTAssertTrue(receivedResult is expectedType)
    }
    
    func testMovieListWorker_fetchMovies_completesOnMainQueue() {
        // Arrange
        let exp = expectation(description: "Expect to fetch movies on main queue")
        var thread: Thread!
        
        // Act
        let dataTask = sut.fetchMovies { _ in
            thread = Thread.current
            exp.fulfill()
        } as! MockURLSessionDataTask
        dataTask.completion(nil, nil, nil)
        
        // Assert
        wait(for: [exp], timeout: 0.2)
        XCTAssertTrue(thread.isMainThread)
    }
    
    func testMovieListWorker_fetchMoviesWithStatus200_completesWithMovieList() {
        // Arrange
        let data = Bundle.loadJSON(fileName: "valid_movies")
        let response = HTTPURLResponse(statusCode: 200)
        let exp = XCTestExpectation(description: "Expects to fetch movies")
        let expectedMovies = parseMovies(data)
        
        var receivedResult: MovieResult!
        var receivedMovies: [Movie]!
        
        // Act
        let dataTask = sut.fetchMovies { result in
            receivedResult = result
            exp.fulfill()
        } as! MockURLSessionDataTask
        dataTask.completion(data, response, nil)
        
        // Assert
        wait(for: [exp], timeout: 0.2)
        XCTAssertNoThrow(receivedMovies = try receivedResult.get())
        XCTAssertEqual(receivedMovies, expectedMovies)
    }
    
    func testMovieListWorker_fetchMoviesWithInvalidResponse_completesWithError() {
        // Arrange
        let exp = XCTestExpectation(description: "Expect to fetch movies with error")
        let expectedError = MovieListWorker.WorkerError.invalidResponse
        
        var receivedResult: MovieResult!
        var receivedError: MovieListWorker.WorkerError!
        
        // Act
        let dataTask = sut.fetchMovies { result in
            receivedResult = result
            exp.fulfill()
        } as! MockURLSessionDataTask
        dataTask.completion(nil, nil, nil)
        
        // Assert
        wait(for: [exp], timeout: 0.2)
        XCTAssertThrowsError(try receivedResult.get()) {
            receivedError = $0 as? MovieListWorker.WorkerError
        }
        XCTAssertEqual(receivedError, expectedError)
    }
}
