//
//  Movie.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
 
    let id: Int
    let original_title: String?
    let original_name: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let release_date: String?
    let first_air_date: String?
    let vote_average: Double?
    let vote_count: Int?

    
}

