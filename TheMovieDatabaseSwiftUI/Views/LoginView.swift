//
//  ContentView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 19.01.2021.
//

import SwiftUI

struct LoginView: View {

    @State private var username: String = ""
    @State private var shouldPushPopularMovies = false

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientView(topColor: .blue, bottomColor: .red)
                VStack {
                    Spacer()
                    Text("Hello \(username)!")
                        .font(.largeTitle)
                    Spacer()
                    Text("Type anything\nIt doesn't matter").font(.title)
                    Spacer()
                    RegularTextField(placeholder: "Enter username",
                                     binding: $username)
                        .padding()
                        .foregroundColor(.black)
                    RegularButton(title: "Login") {
                        shouldPushPopularMovies = true
                    }
                    .disabled(username.isEmpty)

                }.padding()
                NavigationLink(
                    "", destination: PopularMoviesView(),
                    isActive: $shouldPushPopularMovies)
                    .isDetailLink(false)
            }.navigationTitle("Login")
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
