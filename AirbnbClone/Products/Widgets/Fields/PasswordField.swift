//
//  PasswordField.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import SwiftUI

struct PasswordField: View {
    @Binding var passwordValue: String
    var body: some View {
        SecureField("Password", text: $passwordValue)
            .modifier(TextFieldModifier())
    }
}
