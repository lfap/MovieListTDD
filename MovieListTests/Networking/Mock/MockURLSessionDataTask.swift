//
//  MockURLSessionDataTask.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 02/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    var calledResume: Bool = false
    let completion: ((Data?, URLResponse?, Error?) -> Void)
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completionHandler
    }
    
    override func resume() {
        calledResume = true
    }
}
