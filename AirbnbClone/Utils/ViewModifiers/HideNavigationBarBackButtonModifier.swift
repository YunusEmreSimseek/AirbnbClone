//
//  HideNavigationBarBackButtonModifier.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation
import SwiftUI

struct HideNavigationBarBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return
            content
            .toolbar(.hidden, for: .automatic)
    }
}
