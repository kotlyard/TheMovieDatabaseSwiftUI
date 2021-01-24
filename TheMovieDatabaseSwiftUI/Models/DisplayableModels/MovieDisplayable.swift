//
//  MovieDisplayable.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import UIKit

struct MovieDisplayable: Identifiable {
    let id: Int
    let imageUrl: URL
    let name: String
    
    init() {
        id = UUID().hashValue
        imageUrl = URL(string: "https://i.pinimg.com/736x/bc/ec/23/bcec23ae95247f27a8764e53c30f6a85.jpg")!
        name = "sas"
    }

    init(from response: GetPopularMoviesResponse.Result) {
        id = response.id
        
        imageUrl = URL(string: response.posterPath)!
        name = response.originalTitle
    }
}
