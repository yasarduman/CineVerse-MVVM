//
//  MovieError.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


// MARK: - Custom Error Enum
enum MovieError: String, Error {
    case invalidUrl             = "Url Dönüştürülemedi. Please try again."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case unableToFavorite       = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites     = "You've already favorited this user."
}
