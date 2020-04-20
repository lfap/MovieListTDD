//
//  Bundle+Extension.swift
//  MovieListTDDTests
//
//  Created by Luiz F. A. Pio on 15/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

extension Bundle {
    static func loadJSON(fileName name: String) -> Data {
        let bundle = Bundle(for: MovieTests.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            preconditionFailure("File with name: \(name).json couldn't be found")
        }
        
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            preconditionFailure("Loading data from bundle results in error: \(error)")
        }
        return data
    }
}
