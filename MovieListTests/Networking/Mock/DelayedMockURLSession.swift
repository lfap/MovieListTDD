//
//  DelayedMockURLSession.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 15/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class DelayedMockURLSession: MockURLSession {
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return MockURLSessionDataTask { (data, response, error) in
            DispatchQueue(label: "tdd.queue").async {
                completionHandler(data, response, error)
            }
        }
    }
}
