//
//  IndicatorView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import SwiftUI

struct IndicatorView: View {
    @Binding var isLoading: Bool
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.25)
                    .foregroundStyle(.black)
            }
        }

    }
}

#Preview {
    IndicatorView(isLoading: .constant(true))
}
