//
//  MockURLSession.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 02/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    override init() {}
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler)
    }
}
