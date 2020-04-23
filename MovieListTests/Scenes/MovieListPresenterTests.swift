//
//  MovieListPresenterTests.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieListPresenterTests: XCTestCase {

    var sut: MovieListPresenter!
    var worker: MockMovieListWorker!
    var outputViewController: SpyViewController!
    
    override func setUp() {
        worker = MockMovieListWorker()
        outputViewController = SpyViewController()
        sut = MovieListPresenter(worker: worker)
        sut.outputDelegate = outputViewController
    }

    override func tearDown() {
        sut = nil
        worker = nil
        outputViewController = nil
    }
    
    func testMovieListPresenter_initializer() {
        XCTAssertNotNil(sut)
    }
    
    func testMovieListPresenter_setOutputDelegate() {
        XCTAssertTrue((sut.outputDelegate as AnyObject) is MovieListPresenterOutputDelegate)
    }
    
    func testMovieListPresenter_conformsToMovieListPresenterProtocol() {
        XCTAssertTrue((sut as AnyObject) is MovieListPresenterProtocol)
    }
    
    func testMovieListPresenter_declaresFetchMovies() {
        // Arrange
        let sutProtocol = sut as MovieListPresenterProtocol
        
        // Act & Assert
        sutProtocol.fetchMovies()
    }
    
    func testMovieListPresenter_fetchMovies_isCallingWorker() {
        // Act
        sut.fetchMovies()
        
        // Assert
        XCTAssertTrue(worker.fetchMoviesCalled)
    }
    
    func testMovieListPresenter_fetchMovies_isCallingOutput() {
        // Act
        sut.fetchMovies()
        worker.completion(.success([]))
        
        // Assert
        XCTAssertTrue(outputViewController.didFetchMoviesSuccessfullyCalled)
    }
    
    func testMovieListPresenter_fetchMovies_callsOutputPassingListOfMovieViewModel() {
        // Arrange
        let expectedList: [MovieViewModel] = MovieViewModel.viewModels
        
        // Act
        sut.fetchMovies()
        worker.completion(.success(Movie.movies))
        
        // Assert
        XCTAssertEqual(outputViewController.viewModels, expectedList)
    }
    
    func testMovieListPresenter_fetchMoviesWithError_callsOutputPassingErrorMessage() {
        // Arrange
        let expectedMessage: String = MovieListWorker.WorkerError.invalidJSON.presentableMessage
        
        // Act
        sut.fetchMovies()
        worker.completion(.failure(.invalidJSON))
        
        // Assert
        XCTAssertEqual(outputViewController.errorMessage, expectedMessage)
    }
}

extension MovieListPresenterTests {
    
    class SpyViewController: MovieListPresenterOutputDelegate {
        
        var didFetchMoviesSuccessfullyCalled: Bool = false
        var viewModels: [MovieViewModel]!
        var errorMessage: String!
        
        func didFetchMoviesSuccessfully(viewModels: [MovieViewModel]) {
            didFetchMoviesSuccessfullyCalled = true
            self.viewModels = viewModels
        }
        
        func didFetchMovies(withErrorMessage errorMessage: String) {
            self.errorMessage = errorMessage
        }
    }
}
