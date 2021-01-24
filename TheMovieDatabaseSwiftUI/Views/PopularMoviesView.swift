//
//  PopularMoviesView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import SwiftUI
import URLImage

let grid = GridItem()

class PopularMoviewViewModel: ObservableObject, Identifiable {
    let id = UUID()

    @Published var popularMovies: [GetPopularMoviesResponse.Result] = []
    

    init() {
        getPopularMovies()
    }
    
    private func getPopularMovies() {
        NetworkService.getPopularMovies { (movies, error) in
            guard let movies = movies, error == nil else { return print(error) }
            
            DispatchQueue.main.async {
                self.popularMovies = movies.results
            }
        }
    }
}

struct PopularMoviesView: View {
    @ObservedObject var popularMoviesVM: PopularMoviewViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [grid, grid]) {
                    ForEach(popularMoviesVM.popularMovies) {
                        MoviewCell(movie: $0)
                    }
                }
            }.navigationBarTitle("Popular Movies")
        }
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopularMoviesView(popularMoviesVM: PopularMoviewViewModel())
        }
    }
}

struct MoviewCell: View {
    var movie: GetPopularMoviesResponse.Result

    private let cellWidth = UIScreen.main.bounds.width * 0.46

    var body: some View {
        ZStack {
            URLImage(url: URL(string: movie.posterPath)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            Text(movie.originalTitle)
        }
        .frame(width: cellWidth, height: 250, alignment: .center)
        .cornerRadius(8)
    }
}
