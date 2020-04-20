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
        return connector.makeRequest(url: URL(string: "https://myapi.com/path")!) { (data, response, _) in
                
            guard let httpResponse = response as? HTTPURLResponse else {
                self.completesOnMainQueue(result: .failure(.invalidResponse), completion: completion)
                return // Wait for it.
            }
            
            guard httpResponse.statusCode == 200 else {
                return // Wait for it.
            }
            
            guard let data = data else {
                return // Wait for it.
            }
            
            do {
                let movies = try self.parseMovies(data)
                self.completesOnMainQueue(result: .success(movies), completion: completion)
            } catch {
                // Wait for it.
            }
        }
    }
    
    private func parseMovies(_ data: Data) throws -> [Movie] {
        let jsonDecoder = JSONDecoder()
        let movies = try jsonDecoder.decode([Movie].self, from: data)
        return movies
    }
    
    private func completesOnMainQueue(result: MovieResult, completion: @escaping (MovieResult) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

extension MovieListWorker {
    enum WorkerError: Error {
        case invalidResponse
    }
}
