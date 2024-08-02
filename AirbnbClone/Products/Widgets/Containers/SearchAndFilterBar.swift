//
//  SearchAndFilterBar.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import SwiftUI

struct SearchAndFilterBar: View {
    @Binding var destination: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            VStack(alignment: .leading, spacing: 2) {
                Text(destination.isEmpty ? "Where to?" : destination)
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text("Aynwhere - Any week - Add guests")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button(
                action: {},
                label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundStyle(.cBlack)
                }
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .overlay(
            Capsule()
                .stroke(lineWidth: 0.5)
                .foregroundStyle(.gray)
                .shadow(
                    color: .black.opacity(0.4),
                    radius: 2
                )
        )
        //        .padding()
    }
}

//#Preview {
//    SearchAndFilterBar()
//}
