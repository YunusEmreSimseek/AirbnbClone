//
//  ListingItemRateRow.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import Foundation
import SwiftUI

struct ListingItemRateRow: View {
    let rate: String
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
            Text(rate)
        }
        .foregroundStyle(.cBlack)
    }
}
