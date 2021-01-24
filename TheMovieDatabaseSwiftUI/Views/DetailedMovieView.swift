//
//  DetailedMovieView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import SwiftUI

class DetailedMovieViewModel: ObservableObject {

    @Published var movie: DetailedMovie?

    init(movieId: Int) {
        getDetailedMovie(id: movieId)
    }

    private func getDetailedMovie(id: Int) {
        MoviesNetworkService.getMovie(by: id) { (movie, error) in
            guard let movie = movie, error == nil else {
                return print(error.debugDescription)
            }

            DispatchQueue.main.async {
                self.movie = movie
            }
        }
    }

}

struct DetailedMovieView: View {
//    var movieId: Int

    @ObservedObject var movieVM: DetailedMovieViewModel

    var body: some View {
        VStack {
            
        }.ignoresSafeArea()
    }
}

struct DetailedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedMovieView(movieId: 228)
    }
}
