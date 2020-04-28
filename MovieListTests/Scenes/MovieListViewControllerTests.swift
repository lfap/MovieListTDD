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
    var presenter: MockMovieListPresenter!

    override func setUp() {
        presenter = MockMovieListPresenter()
        sut = MovieListViewController()

        sut.presenter = presenter
        presenter.outputDelegate = sut
    }

    override func tearDown() {
        sut = nil
        presenter = nil
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
    
    func testMovieListViewController_declaresPresenter() {
        XCTAssertTrue((sut.presenter as AnyObject) is MovieListPresenterProtocol)
    }
        
    func testMovieListViewController_declaresTableView() {
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertTrue((sut.tableView as AnyObject) is UITableView)
    }
    
    func testMovieListViewController_tableViewDelegateAndDataSourceConfigured() {
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testMovieListViewController_dequeuesCell() {
        // Arrange
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        presenter.result = .success(MovieViewModel.viewModels)
        
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testMovieListViewController_callingFetchMovies() {
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertTrue(presenter.fetchMoviesCalled)
    }
    
    func testMovieListViewController_afterFetchMoviesSuccessfully_setsTheAmountOfRows() {
        // Arrange
        let viewModels = MovieViewModel.viewModels
        presenter.result = .success(viewModels)
            
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        let rows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, viewModels.count)
    }
    
    func testMovieListViewController_afterFetchMoviesSuccessfully_configureCellWithValues() {
        // Arrange
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        let firstViewModel = MovieViewModel.viewModels.first!
        presenter.result = .success(MovieViewModel.viewModels)
                
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertEqual(cell.textLabel?.text, firstViewModel.title)
    }
}
