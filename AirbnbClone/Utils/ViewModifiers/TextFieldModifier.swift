//
//  TextFieldModifier.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    private let screenSize: CGSize = GlobalScreenSize.size
    func body(content: Content) -> some View {
        return
            content
            .font(.footnote)
            .foregroundStyle(.cBlack)
            .vPadding(.medium)
            .hPadding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.75))
            .foregroundStyle(.cBlack)

    }
}
