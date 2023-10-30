//
//  Movie.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    
    let id: Int?
    let name: String?
    let originalName: String?
    let title: String?
    let originalTitle: String?
    let releaseDate: String?
    let firstAirDate: String?
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    
}

