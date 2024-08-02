//
//  EmailField.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import SwiftUI

struct EmailField: View {
    @Binding var emailValue: String
    var body: some View {
        TextField("Email", text: $emailValue)
            .modifier(TextFieldModifier())
            .keyboardType(.emailAddress)

    }
}
