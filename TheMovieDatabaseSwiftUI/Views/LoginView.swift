//
//  ContentView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 19.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        ZStack {
            BackgroundView(topColor: .blue, bottomColor: .red)
            VStack {
                Spacer()
                RegularTextField(placeholder: "Enter username",
                                 binding: $username)
                    .padding()
                RegularTextField(placeholder: "Enter password",
                                 binding: $password)
                    .padding()
                RegularButton(title: "Login")
                    .padding()
            }.padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct RegularButton: View {
    var title: String

    var body: some View {
        Button(action: {
            
        }, label: {
            Text(title)
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
        })
    }
}

struct RegularTextField: View {
    var placeholder: String
    var binding: Binding<String>

    var body: some View {
        TextField(placeholder, text: binding)
            .frame(width: 300, height: 40)
            .background(Color.white)
            .cornerRadius(5)
    }
}
