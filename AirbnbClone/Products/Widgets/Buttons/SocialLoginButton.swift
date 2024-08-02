//
//  SocialLoginButton.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 30.07.2024.
//

import Foundation
import SwiftUI

struct SocialLoginButton: View {
    let image: ImageResource
    let title: String
    let titleColor: Color
    let bgColor: Color
    let onTap: () -> Void
    var body: some View {
        VStack {
            Button(
                action: onTap,
                label: {
                    HStack(spacing: .dynamicWidth(width: 0.1)) {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: .dynamicWidth(width: 0.1),
                                height: .dynamicHeight(height: 0.03)
                            )
                        Text(title)
                            .font(.subheadline)
                            //                            .fontWeight(.semibold)
                            .foregroundStyle(.cBlack)
                        Spacer()
                    }
                    .vPadding(.normal)
                    .hPadding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.75)
                            .foregroundStyle(.gray)
                    )

                }
            )
        }
    }
}
