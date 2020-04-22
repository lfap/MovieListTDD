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
    var outputViewController: MovieListPresenterOutputDelegate!
    
    override func setUp() {
        worker = MockMovieListWorker()
        outputViewController = SpyViewController()
        sut = MovieListPresenter(worker: worker)
        sut.outputDelegate = outputViewController
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMovieListPresenter_initializer() {
        XCTAssertNotNil(sut)
    }
    
    func testMovieListPresenter_initilizerWithWorker() {
        // Arrange
        let worker = MockMovieListWorker()
        
        // Act & Assert
        sut = MovieListPresenter(worker: worker)
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
}

extension MovieListPresenterTests {
    class SpyViewController: MovieListPresenterOutputDelegate {
        
    }
}
