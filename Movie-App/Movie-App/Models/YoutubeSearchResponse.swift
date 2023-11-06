//
//  YoutubeSearchResponse.swift
// Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import Foundation



struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
