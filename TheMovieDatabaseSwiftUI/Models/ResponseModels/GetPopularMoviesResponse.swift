//
//  GetPopularMoviesResponse.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import Foundation

// MARK: - GetPopularMoviesResponse
struct GetPopularMoviesResponse: Decodable {

    let page: Int
    let results: [Result]
    let totalResults: Int
    let totalPages: Int


    // MARK: - Result
    struct Result: Decodable, Identifiable {
        let posterPath: String
        let adult: Bool
        let overview: String
        let releaseDate: String
        let genreids: [Int]
        let id: Int
        let originalTitle: String
        let originalLanguage: OriginalLanguage
        let title: String
        let backdropPath: String
        let popularity: Double
        let voteCount: Int
        let video: Bool
        let voteAverage: Double
    }

    enum OriginalLanguage: String, Decodable {
        case en
    }

}



