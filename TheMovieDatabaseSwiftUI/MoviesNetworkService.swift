//
//  NetworkService.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import Foundation
import UIKit

protocol MoviesNetworkProvidable: class {

    static func getPopularMovies(_ completion: @escaping (GetPopularMoviesResponse?, Error?) -> Void)
    static func getMovie(by id: String, _ completion: @escaping (GetMovieResponse?, Error?) -> Void)

}


final class MoviesNetworkService: MoviesNetworkProvidable {
    private static let apiKey = "edc593927fcc046752e28da2a8bddb0e"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"

    static func getPopularMovies(_ completion: @escaping (GetPopularMoviesResponse?, Error?) -> Void) {
        // Creating base url component
        guard var baseUrl = URLComponents(string: "https://api.themoviedb.org/3/movie/popular") else {
            return completion(nil, nil)
        }

        // Creating query items
        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "region", value: "ua"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]

        baseUrl.queryItems = queryItems
        guard let url = baseUrl.url else { return completion(nil, nil) }

        // Performing request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return completion(nil, error) }
            
            print("Response: \(String(data: data, encoding: .utf8))")
            
            guard let popularMovies = try? JSONDecoder().decode(GetPopularMoviesResponse.self,
                                                                from: data) else {
                return completion(nil, nil)
            }

            completion(popularMovies, nil)
        }.resume()

    }

    static func getMovie(by id: String, _ completion: (GetMovieResponse?, Error?) -> Void) {
        
    }

}
