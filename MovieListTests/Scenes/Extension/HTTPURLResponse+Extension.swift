//
//  HTTPURLResponse+Extension.swift
//  MovieListTDDTests
//
//  Created by Luiz F. A. Pio on 15/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    /**
     Convenience initializer of HTTPURLResponse with default values for url and statusCode
     
     - Parameter url: default value = "http://api.com/path"
     - Parameter statusCode: default value = 200
                
     */
    convenience init(url: URL = URL(string: "http://api.com/path")!, statusCode: Int) {
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
