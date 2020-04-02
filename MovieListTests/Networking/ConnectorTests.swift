//
//  ConnectorTests.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 02/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest
@testable import MovieList

class ConnectorTests: XCTestCase {
    
    var sut: Connector!
    var provider: MockURLSession!
    var url: URL!

    override func setUp() {
        provider = MockURLSession()
        sut = Connector(provider: provider)
        url = URL(string: "myapi.com/path")!
    }
    
    override func tearDown() {
        sut = nil
        provider = nil
        url = nil
    }
    
    func testConnector_initializer() {
        XCTAssertNotNil(sut)
    }
    
    func testConnector_initializeWithProvider_setsProvider() {
        XCTAssertEqual(sut.provider, provider)
    }
    
    func testConnector_declaresMakeRequest_returnDataTask() {
        // Act
        let dataTask = sut.makeRequest(url: url) { _, _, _ in }
        
        // Assert
        XCTAssertTrue(dataTask is MockURLSessionDataTask)
    }
    
    func testConnector_makeRequest_isFiring() {
        // Act
        let dataTask = sut.makeRequest(url: url) { (_, _, _) in } as! MockURLSessionDataTask
        
        // Assert
        XCTAssertTrue(dataTask.calledResume)
    }
}
