//
//  RegularButton.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 24.01.2021.
//

import SwiftUI

struct RegularButton: View {
    var title: String
    var action: (() -> Void)?

    var body: some View {
        Button(action: {
            action?()
        }, label: {
            Text(title)
                .foregroundColor(.white)
        })
        .frame(width: 300, height: 50)
        .background(Color.blue)
        .cornerRadius(10)
        
    }
}


struct RegularButton_Previews: PreviewProvider {
    static var previews: some View {
        RegularButton(title: "Sas")
    }
}
