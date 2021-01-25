//
//  MovieCredits.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 25.01.2021.
//

import Foundation

// MARK: - MovieCredits
struct MovieCredits: Codable {
    let id: Int
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable, Identifiable, Hashable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String?
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castid: Int?
    let character: String?
    let creditid: String
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castid = "cast_id"
        case character
        case creditid = "credit_id"
        case order, department, job
    }
}
