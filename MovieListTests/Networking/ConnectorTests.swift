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
    
    // MARK: - Act
    private func actMakeRequest(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) -> (data: Data?, response: URLResponse?, error: Error?) {
        
        var receivedData: Data?
        var receivedResponse: URLResponse?
        var receivedError: Error?
        
        let dataTask = sut.makeRequest(url: url) { (data, response, error) in
            receivedData = data
            receivedResponse = response
            receivedError = error
        } as! MockURLSessionDataTask
        dataTask.completion(data, response, error)
        
        return (receivedData, receivedResponse, receivedError)
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
    
    func testConnector_makeRequest_receivesData() {
        // Arrange
        let expectedData: Data = #"{"name": "John"}"#.data(using: .utf8)!
        
        // Act
        let result = actMakeRequest(data: expectedData)
        
        // Assert
        XCTAssertEqual(result.data, expectedData)
    }
    
    func testConnector_makesRequest_receivesResponse() {
        // Arrange
        let expectedResponse: URLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        // Act
        let result = actMakeRequest(response: expectedResponse)

        // Assert
        XCTAssertEqual(result.response, expectedResponse)
    }
    
    func testConnector_makesRequest_receivesError() {
        // Arrange
        let expectedError: NSError = NSError(domain: "TDD", code: 0, userInfo: nil)
        
        // Act
        let result = actMakeRequest(error: expectedError)
        
        // Assert
        let actualError = result.error as NSError?
        XCTAssertEqual(actualError, expectedError)
    }
}
