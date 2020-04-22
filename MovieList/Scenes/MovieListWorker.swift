//
//  MovieListWorker.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 08/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

typealias MovieResult = Result<[Movie], MovieListWorker.WorkerError>

protocol MovieListWorkerProtocol {
    func fetchMovies(_ completion: @escaping (MovieResult) -> Void) -> URLSessionDataTask
}

class MovieListWorker: MovieListWorkerProtocol {
    private let connector: Connector
    
    init(connector: Connector = Connector()) {
        self.connector = connector
    }
    
    func fetchMovies(_ completion: @escaping (MovieResult) -> Void) -> URLSessionDataTask {
        return connector.makeRequest(url: URL(string: "https://myapi.com/path")!) { (data, response, error) in
                
            guard error == nil else {
                let description = error!.localizedDescription
                let error: WorkerError = .undefined(description: description)
                self.completesOnMainQueue(result: .failure(error), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.completesOnMainQueue(result: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                self.completesOnMainQueue(result: .failure(.invalidStatusCode), completion: completion)
                return
            }
            
            guard let data = data else {
                self.completesOnMainQueue(result: .failure(.invalidData), completion: completion)
                return
            }
            
            do {
                let movies = try self.parseMovies(data)
                self.completesOnMainQueue(result: .success(movies), completion: completion)
            } catch {
                self.completesOnMainQueue(result: .failure(.invalidJSON), completion: completion)
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
    enum WorkerError: Error, Equatable {
        case undefined(description: String)
        case invalidResponse
        case invalidStatusCode
        case invalidData
        case invalidJSON
    }
}
