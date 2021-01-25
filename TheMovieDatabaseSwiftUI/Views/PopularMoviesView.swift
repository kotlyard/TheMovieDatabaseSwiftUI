//
//  PopularMoviesView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import SwiftUI
import URLImage

//MARK: - ViewModel
class PopularMoviewViewModel: ObservableObject, Identifiable {

    let id = UUID()

    @Published var popularMovies: [PopularMovie] = []

    func getPopularMovies() {
        MoviesNetworkService.getPopularMovies { (movies, error) in
            guard let movies = movies, error == nil else {
                return print(error.debugDescription)
            }

            DispatchQueue.main.async {
                self.popularMovies = movies.results
            }
        }
    }
}

//MARK: - PopularMoviesView
struct PopularMoviesView: View {
    @ObservedObject var popularMoviesVM = PopularMoviewViewModel()

    private let gridLayout = [GridItem(), GridItem()]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout) {
                ForEach(popularMoviesVM.popularMovies) { movie in
                    NavigationLink(
                        destination: DetailedMovieView(movieId: movie.id),
                        label: {
                            MovieCell(movie: movie)
                        })
                }
            }
        }.navigationBarTitle("Popular Movies")
        .onAppear {
            if popularMoviesVM.popularMovies.isEmpty {
                popularMoviesVM.getPopularMovies()
            }
        }
    }
}

// MARK: - MovieCell
struct MovieCell: View {
    var movie: PopularMovie

    private let cellWidth = UIScreen.main.bounds.width * 0.46

    var body: some View {
        let alignment = Alignment(horizontal: .leading, vertical: .bottom)

        ZStack(alignment: alignment) {
            if let url = MoviesNetworkService.createImageUrl(path: movie.posterPath) {
                URLImage(url: url ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            Color.black.opacity(0.8).frame(width: cellWidth, height: cellWidth * 0.275)
            Text(movie.title)
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color.white.opacity(0.8))
                .offset(x: 5, y: -cellWidth * 0.1 - 5)
        }
        .frame(width: cellWidth, height: 250)
        .cornerRadius(10)
    }
}


// MARK: - Preview
struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopularMoviesView(popularMoviesVM: PopularMoviewViewModel())
        }
    }
}
