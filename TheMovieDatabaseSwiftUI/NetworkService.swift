//
//  NetworkService.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import Foundation
import UIKit

protocol NetworkProvidable: class {
    static func getPopularMovies(_ completion: (GetPopularMoviesResponse?, Error?) -> Void)
    static func authUser()
    static func getMovie(by id: String, _ completion: (GetMovieResponse?, Error?) -> Void)
}


final class NetworkService: NetworkProvidable {
    private let bearer = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZGM1OTM5MjdmY2MwNDY3NTJlMjhkYTJhOGJkZGIwZSIsInN1YiI6IjYwMDg1ZTU0ZGUxMWU1MDAzZjMyNDVlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Y8f0ZsgQAfEKTe0I81DnNbIoBFEQlWGXynSHV78jjcc"

    static func getPopularMovies(_ completion: (GetPopularMoviesResponse?, Error?) -> Void) {
            
    }
    
    static func authUser() {
        
    }
    
    static func getMovie(by id: String, _ completion: (GetMovieResponse?, Error?) -> Void) {
        
    }

}
