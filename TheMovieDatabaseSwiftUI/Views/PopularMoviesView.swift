//
//  PopularMoviesView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import SwiftUI
import URLImage

let grid = GridItem()
let data = [
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable(),
    MovieDisplayable()
]

struct PopularMoviesView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [grid, grid]) {
                    ForEach(data) {
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
            PopularMoviesView()
        }
    }
}

struct MoviewCell: View {
    var movie: MovieDisplayable

    private let cellWidth = UIScreen.main.bounds.width * 0.46

    var body: some View {
        ZStack {
            URLImage(url: movie.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            Text(movie.name)
        }
        .frame(width: cellWidth, height: 250, alignment: .center)
        .cornerRadius(8)
    }
}
