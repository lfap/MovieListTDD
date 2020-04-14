//
//  Connector.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 02/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class Connector {
    let provider: URLSession
    
    init(provider: URLSession = URLSession.shared) {
        self.provider = provider
    }
    
    func makeRequest(url: URL, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let dataTask = provider.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        dataTask.resume()
        return dataTask
    }
}
