//
//  Movie.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 08/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let name: String
    let year: Int
    
    init(name: String, year: Int) {
        self.name = name
        self.year = year
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        let sameName = lhs.name == rhs.name
        let sameYear = lhs.year == rhs.year
        return sameName && sameYear
    }
}
