//
//  ToolbarIndicatorModifier.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation
import SwiftUI

struct ToolbarIndicatorModifier: ViewModifier {
    @Binding var isLoading: Bool
    func body(content: Content) -> some View {
        return
            content
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    IndicatorView(isLoading: $isLoading)
                }

            }

            )
    }
}
