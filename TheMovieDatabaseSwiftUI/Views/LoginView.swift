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
                BackgroundView(topColor: .blue, bottomColor: .red)
                VStack {
                    Spacer()
                    Text("Hello \(username)!")
                        .font(.largeTitle)
                    Spacer()
                    RegularTextField(placeholder: "Enter username",
                                     binding: $username)
                        .padding()
                    RegularButton(title: "Login") {
                        shouldPushPopularMovies = true
                    }
                    .disabled(username.isEmpty)
                    
                }.padding()
                NavigationLink(
                    "", destination: PopularMoviesView(),
                    isActive: $shouldPushPopularMovies)
                }

        }.navigationTitle("Login")
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
