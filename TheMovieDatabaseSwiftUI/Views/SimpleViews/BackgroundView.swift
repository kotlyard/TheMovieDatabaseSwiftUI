//
//  BackgroundView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 24.01.2021.
//

import SwiftUI


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

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(topColor: .black, bottomColor: .orange)
    }
}
