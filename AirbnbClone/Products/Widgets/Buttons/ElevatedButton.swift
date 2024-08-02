//
//  ElevatedButton.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 2.08.2024.
//

import Foundation
import SwiftUI

struct ElevatedButton: View {
    let title: String
    let onTap: () -> Void
    var body: some View {
            HStack {
                Spacer()
                Button(
                    action: onTap,
                    label: {
                        HStack {
                            Spacer()
                            Text(title)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundStyle(.cWhite)
                                .vPadding(.medium)
                            Spacer()
                        }
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                )
                Spacer()
            }
    }
}
