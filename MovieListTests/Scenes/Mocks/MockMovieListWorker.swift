//
//  MockMovieListWorker.swift
//  MovieListTests
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
@testable import MovieList

class MockMovieListWorker: MovieListWorkerProtocol {
    var fetchMoviesCalled: Bool = false
    var completion: ((MovieResult) -> Void)!
    
    func fetchMovies(_ completion: @escaping (MovieResult) -> Void) -> URLSessionDataTask {
        fetchMoviesCalled = true
        self.completion = completion
        return MockURLSessionDataTask { (_, _, _) in }
    }
}
