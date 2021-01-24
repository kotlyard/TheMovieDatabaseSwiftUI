//
//  GetPopularMoviesResponse.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import Foundation

// MARK: - GetPopularMoviesResponse
struct GetPopularMoviesResponse: Codable {
    let page: Int
    let results: [PopularMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}

// MARK: - Result
struct PopularMovie: Codable, Identifiable {

    let adult: Bool
    let backdropPath: String
    let genreids: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreids = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

}
