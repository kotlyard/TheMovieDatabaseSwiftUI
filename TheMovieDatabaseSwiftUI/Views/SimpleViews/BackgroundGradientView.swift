//
//  BackgroundView.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 24.01.2021.
//

import SwiftUI


struct BackgroundGradientView: View {
    var topColor: Color
    var bottomColor: Color
    var startPoint: UnitPoint = .topLeading
    var endPoint: UnitPoint = .bottomLeading

    var body: some View {
        let gradient = Gradient(colors: [topColor, bottomColor])

        LinearGradient(gradient: gradient,
                       startPoint: startPoint,
                       endPoint: endPoint)
            .ignoresSafeArea()
    }
}

struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView(topColor: .black, bottomColor: .orange)
    }
}
