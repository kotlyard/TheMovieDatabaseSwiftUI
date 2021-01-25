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
        guard let movie = movieVM.movie else {
            return AnyView(
                ProgressView("Downloading movie data...")
                    // Get movie data by id on appear
                    .onAppear(perform: {
                        // I added a delay because getting data is too quick to notice loader
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            movieVM.getDetailedMovie(id: movieId)
                        }
                    })
            )
        }

        return AnyView(
            ScrollView {
                VStack(alignment: .center, spacing: 5) {
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

                    // MARK: - General Info
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Released").fontWeight(.semibold).font(.title3)
                            Text(movie.releaseDate).foregroundColor(.gray)
                        }.padding(.leading)
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Genre").fontWeight(.semibold).font(.title3)
                            Text(movie.genres.first?.name ?? "No genre").foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Language").fontWeight(.semibold).font(.title3)
                            Text(movie.originalLanguage).foregroundColor(.gray)
                        }.padding(.trailing)
                        Spacer()
                    }
                    Spacer()
                    Text("Synopsis")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(movie.overview)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing], 70)
                        .multilineTextAlignment(.leading)

                    // MARK: - Main cast

                    List() {
                        
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

struct CastView: View {
    var cast: Cast

    var body: some View {
        Text("sas")
    }

}

// MARK: - Preview
struct DetailedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedMovieView(movieId: 228)
    }
}
