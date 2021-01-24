//
//  PopularMoviesView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import SwiftUI
import URLImage

class PopularMoviewViewModel: ObservableObject, Identifiable {

    let id = UUID()

    @Published var popularMovies: [PopularMovie] = []

    init() {
        getPopularMovies()
    }

    private func getPopularMovies() {
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

struct PopularMoviesView: View {
    @ObservedObject var popularMoviesVM = PopularMoviewViewModel()

    private let gridLayout = [GridItem(), GridItem()]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout) {
                ForEach(popularMoviesVM.popularMovies) { movie in
                    NavigationLink(
                        destination: DetailedMovieView(movieVM: DetailedMovieViewModel(movieId: movie.id)),
                        label: {
                            MovieCell(movie: movie)
                        })
                }
            }
        }.navigationBarTitle("Popular Movies")
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopularMoviesView(popularMoviesVM: PopularMoviewViewModel())
        }
    }
}

struct MovieCell: View {
    var movie: PopularMovie

    private let cellWidth = UIScreen.main.bounds.width * 0.46

    var body: some View {
        let alignment = Alignment(horizontal: .center, vertical: .bottom)

        ZStack(alignment: alignment) {
            #warning("remove force unwrap!")
            URLImage(url: URL(string: MoviesNetworkService.imageBaseUrl + movie.posterPath)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            Text(movie.title)
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.white.opacity(0.8))
                .padding([.leading, .bottom], 5)
                .frame(width: cellWidth,
                       height: 35,
                       alignment: .leading)
                .background(Color.black.opacity(0.8))
        }
        .frame(width: cellWidth, height: 250, alignment: .center)
        .cornerRadius(10)
    }
}
