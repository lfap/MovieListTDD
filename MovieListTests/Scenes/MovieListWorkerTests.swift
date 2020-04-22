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
    
    // MARK: - Act
    private func actFetchMovies(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) -> MovieResult {
        let exp = expectation(description: "Expect to fetch movies")
        var thread: Thread!
        var receivedResult: MovieResult!
        
        let dataTask = sut.fetchMovies { movieResult in
            thread = Thread.current
            receivedResult = movieResult
            exp.fulfill()
        } as! MockURLSessionDataTask
        dataTask.completion(data, response, error)
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertTrue(thread.isMainThread)
        
        return receivedResult
    }
    
    // MARK: - Tests
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
        // Act
        let result = actFetchMovies()
        
        // Assert
        XCTAssertTrue((result as Any) is MovieResult)
    }
    
    func testMovieListWorker_fetchMoviesWithStatus200_completesWithMovieList() {
        // Arrange
        let data = Bundle.loadJSON(fileName: "valid_movies")
        let response = HTTPURLResponse(statusCode: 200)
        let expectedMovies = parseMovies(data)
        
        var receivedMovies: [Movie]!
        
        // Act
        let result = actFetchMovies(data: data, response: response)
        
        // Assert
        XCTAssertNoThrow(receivedMovies = try result.get())
        XCTAssertEqual(receivedMovies, expectedMovies)
    }
    
    func testMovieListWorker_fetchMoviesWithNonNilError_completesWithUndefinedError() {
        // Arrange
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey: "Undefined error description"]
        let error = NSError(domain: "tdd", code: 0, userInfo: userInfo)
        let expectedError = MovieListWorker.WorkerError.undefined(description: error.localizedDescription)
        var receivedError: MovieListWorker.WorkerError!

        // Act
        let result = actFetchMovies(error: error)
        
        // Assert - Without XCTestCase+Extension
        XCTAssertThrowsError(try result.get()) {
            receivedError = $0 as? MovieListWorker.WorkerError
        }
        XCTAssertEqual(receivedError, expectedError)
    }
    
    func testMovieListWorker_fetchMoviesWithInvalidResponse_completesWithInvalidResponseError() {
        // Arrange
        let expectedError = MovieListWorker.WorkerError.invalidResponse
        
        // Act
        let result = actFetchMovies()
        
        // Assert - With XCTestCase+Extension
        assert(try result.get(), toThrow: expectedError)
    }
}
