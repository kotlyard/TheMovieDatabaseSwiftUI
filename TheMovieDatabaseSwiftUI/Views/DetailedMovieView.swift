//
//  DetailedMovieView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 20.01.2021.
//

import SwiftUI
import URLImage

//MARK: - ViewModel
class DetailedMovieViewModel: ObservableObject {
    
    @Published var movie: DetailedMovie?
    @Published var credits: MovieCredits?

    var genresFormatted: String {
        guard let genres = movie?.genres else { return "" }

        return genres
            .reduce("", { $0 == "" ? $1.name : $0 + "," + $1.name })
    }

    func getDetailedMovie(id: Int) {
        MoviesNetworkService.getMovie(by: id) { (movie, error) in
            guard let movie = movie, error == nil else {
                return print(error.debugDescription)
            }
            
            DispatchQueue.main.async {
                self.movie = movie
            }
        }

        MoviesNetworkService.getMovieCredits(movieId: id) { (credits, error) in
            guard let credits = credits, error == nil else {
                return print(error.debugDescription)
            }
            
            DispatchQueue.main.async {
                self.credits = credits
            }
        }
    }

    func shareMovie() {
        guard let movie = movie else { return }
        
        let av = UIActivityViewController(activityItems: [movie.title], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
}

//MARK: - DetailedMovieView
struct DetailedMovieView: View {

    var movieId: Int

    @ObservedObject private var movieVM = DetailedMovieViewModel()
    
    var body: some View {
        guard let movie = movieVM.movie,
              let _ = movieVM.credits else {
            return AnyView(
                ProgressView("Downloading movie data...")
                    // Get movie data by id on appear
                    .onAppear(perform: {
                        // I added a delay because receiving data is too fast to notice loader
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            movieVM.getDetailedMovie(id: movieId)
                        }
                    })
            )
        }

        return AnyView(
            ScrollView {
                LazyVStack(alignment: .center, spacing: 5) {
                    // MARK: - Header
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        URLImage(url: URL(string: MoviesNetworkService.imageBaseUrl + movie.backdropPath)! ) { image in
                            image
                                .aspectRatio(contentMode: .fill)
                        }
                        Button(action: {}, label: {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .background(Color.white)
                                .cornerRadius(37.5)
                        }).frame(width: 75, height: 75)
                        .alignmentGuide(.bottom, computeValue: { _ in
                            return 45
                        }).offset(x: -50, y: 0)
                    }.frame(maxWidth: .infinity, maxHeight: 300)
                    Spacer(minLength: 15)
                    // MARK: - General Info
                    HStack(alignment: .center) {
                        GeneralInfoView(title: "Released", text: movie.releaseDate)
                            .padding(.leading)
                        Spacer()
                        GeneralInfoView(title: "Genre", text: movie.genres.first?.name ?? "Some shit")
                        Spacer()
                        GeneralInfoView(title: "Released", text: movie.releaseDate)
                            .padding(.trailing)
                    }
                    Group {
                        Spacer(minLength: 15)
                        Text("Synopsis")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        Spacer()
                        Text(movie.overview)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 15)
                    // MARK: - Main cast
                    Group {
                        Text("Main Cast")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(alignment: .center, spacing: 25) {
                                ForEach(movieVM.credits?.cast ?? []) {
                                    CastView(cast: $0)
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                    Spacer()
                    // MARK: - Main technical team
                    Group {
                        Text("Main technical team")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(), GridItem()]) {
                                ForEach(movieVM.credits?.crew ?? [], id: \.self) {
                                    Text($0.name)
                                        .padding()
                                    Text($0.job ?? "Loser")
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                        .padding()
                                }
                            }
                        }.padding(.bottom, 25)
                    }
                }
            }.navigationBarTitle(movie.title, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                movieVM.shareMovie()
            }, label: {
                Image(systemName: "square.and.arrow.up").font(.title2)
            }))
            
        )
    }
}

// MARK: - CastView
struct CastView: View {
    var cast: Cast

    private let imageSide: CGFloat = 75

    var body: some View {
        guard let url = MoviesNetworkService.createImageUrl(path: cast.profilePath) else {
            return AnyView(
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: imageSide, height: imageSide)
                )
        }
        return AnyView(
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                URLImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: imageSide, height: imageSide)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(imageSide / 2)
                }
                Text(cast.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .frame(maxWidth: imageSide * 1.3)
            }
        )
    }

}

// MARK: - GeneralInfoView
struct GeneralInfoView: View {

    var title: String
    var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).fontWeight(.semibold).font(.title3)
            Text(text).foregroundColor(.gray)
        }
    }
}

// MARK: - Preview
struct DetailedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedMovieView(movieId: 228)
    }
}
