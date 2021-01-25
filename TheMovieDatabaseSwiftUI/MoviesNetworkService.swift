//
//  NetworkService.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import Foundation
import UIKit


protocol MoviesNetworkProvidable: class {

    static func getPopularMovies(page: Int, _ completion: @escaping (PopularMoviesResponse?, Error?) -> Void)
    static func getMovie(by id: Int, _ completion: @escaping (DetailedMovie?, Error?) -> Void)

}


final class MoviesNetworkService: MoviesNetworkProvidable {
    private static let apiKey = "edc593927fcc046752e28da2a8bddb0e"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"

    static func getPopularMovies(page: Int = 1, _ completion: @escaping (PopularMoviesResponse?, Error?) -> Void) {
        // Creating base url component
        guard var baseUrl = URLComponents(string: "https://api.themoviedb.org/3/movie/popular") else {
            return completion(nil, nil)
        }

        // Creating query items
        baseUrl.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "region", value: "ua"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)"),
        ]

        guard let url = baseUrl.url else { return completion(nil, nil) }

        // Performing request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            handleResponse(data: data, error: error, urlResponse: response, completion: completion)
        }.resume()

    }

    static func getMovie(by id: Int, _ completion: @escaping (DetailedMovie?, Error?) -> Void) {
        // Creating base url component
        guard var baseUrl = URLComponents(string: "https://api.themoviedb.org/3/movie/\(id)") else {
            return completion(nil, nil)
        }

        // Creating query items
        baseUrl.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
 
        guard let url = baseUrl.url else { return completion(nil, nil) }

        // Performing request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            handleResponse(data: data, error: error, urlResponse: response, completion: completion)
        }.resume()
    }

    static func createImageUrl(path: String?) -> URL? {
        guard let path = path,
              let url = URL(string: imageBaseUrl + path) else { return nil }

        return url
    }

    static func getMovieCredits(movieId id: Int, _ completion: @escaping (MovieCredits?, Error?) -> Void) {
        guard var baseUrl = URLComponents(string: "https://api.themoviedb.org/3/movie/\(id)/credits") else {
            return completion(nil, nil)
        }

        // Creating query items
        baseUrl.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        
        guard let url = baseUrl.url else { return completion(nil, nil) }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            handleResponse(data: data, error: error, urlResponse: response, completion: completion)
        }.resume()

    }

    static func handleResponse<T: Decodable>(data: Data?,
                                             error: Error?,
                                             urlResponse: URLResponse?,
                                             completion: @escaping (T?, Error?) -> Void) {
        guard let data = data, error == nil else { return completion(nil, error) }

        print("Response:", "\(String(data: data, encoding: .utf8) ?? "No response data")")

        guard let httpResponse = urlResponse as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return completion(nil, nil)
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            completion(decodedResponse, nil)
        } catch {
            print(error)
            completion(nil, nil)
        }
    }

}
