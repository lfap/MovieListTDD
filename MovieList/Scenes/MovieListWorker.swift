//
//  MovieListWorker.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 08/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation


typealias MovieResult = Result<[Movie], MovieListWorker.WorkerError>
class MovieListWorker {
    private let connector: Connector
    
    init(connector: Connector = Connector()) {
        self.connector = connector
    }
    
    func fetchMovies(_ completion: @escaping (MovieResult) -> Void) -> URLSessionDataTask {
        return connector.makeRequest(url: URL(string: "https://myapi.com/path")!) { (_, _, _) in
            completion(.success([]))
        }
    }
}

extension MovieListWorker {
    enum WorkerError: Error {
        
    }
}
