//
//  APICaller.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import Foundation

struct Constants {
    static let API_KEY = "9f34b030b7187aab01fbc340d02601ee"
    static let baseURL = "https://api.themoviedb.org"
    //static let YoutubeAPI_KEY = "AIzaSyCPmahsG3SOBFZ7TD5bYVfKygfIrxpbjnE"
    static let YoutubeAPI_KEY = "AIzaSyBaWHkGN5wJs9rJzawpDJ40cNV1C7FYsC4"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APICaller {
    static let shared = APICaller()
    let decoder = JSONDecoder()
    
    func getTrendingMovies() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    func getTrendingTVs() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    func getUpcomingMovies() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    
    func getPopular() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    func getTopRated() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    
    func getDiscoverMovies() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    
    
    func search(with query: String) async throws -> MovieResponse {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {  throw MovieError.invalidUrl  }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            throw MovieError.invalidUrl
        }
      
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    func getMovie(with query: String) async throws -> VideoElement {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { throw MovieError.invalidUrl}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { throw MovieError.invalidUrl}
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
            
             return results.items[0]
        } catch {
            throw MovieError.invalidData
        }
    }
}
