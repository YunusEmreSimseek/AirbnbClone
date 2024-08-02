//
//  BackButton.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(
            action: {
                dismiss()
            },
            label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .background {
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.white)
                    }
                    .padding(32)
            }

        )
    }
}
