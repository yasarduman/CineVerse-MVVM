//
//  APICaller.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import Foundation
import UIKit

struct Constants {
    static let API_KEY = "9f34b030b7187aab01fbc340d02601ee"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}
class APICaller {
    static let shared = APICaller()
    let decoder = JSONDecoder()
    
    func getTrendingMovies() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            throw APIError.failedTogetData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.failedTogetData
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw APIError.failedTogetData
        }
    }
    
    func getTrendingTVs() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {
            throw APIError.failedTogetData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.failedTogetData
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw APIError.failedTogetData
        }
    }
    
    func getUpcomingMovies() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw APIError.failedTogetData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.failedTogetData
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw APIError.failedTogetData
        }
    }
    
    
    func getPopular() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw APIError.failedTogetData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.failedTogetData
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw APIError.failedTogetData
        }
    }
    
    func getTopRated() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw APIError.failedTogetData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.failedTogetData
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw APIError.failedTogetData
        }
    }
    
    
    func getDiscoverMovies() async throws -> MovieResponse {

        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
            throw APIError.failedTogetData
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.failedTogetData
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw APIError.failedTogetData
        }
    }
    
    
    func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))

            } catch {
                completion(.failure(APIError.failedTogetData))
            }

        }
        task.resume()
    }
    
    
//    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
//        
//
//        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
//        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            
//            do {
//                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
//                
//                completion(.success(results.items[0]))
//                
//
//            } catch {
//                completion(.failure(error))
//                print(error.localizedDescription)
//            }
//
//        }
//        task.resume()
//    }
    
}





