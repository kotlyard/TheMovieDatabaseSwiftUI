//
//  RegularTextField.swift
//  TheMovieDatabaseSwiftUI
//
//  Created by kotl on 24.01.2021.
//

import SwiftUI

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
