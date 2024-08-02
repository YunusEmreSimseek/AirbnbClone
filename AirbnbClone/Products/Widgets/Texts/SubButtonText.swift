//
//  SubButtonText.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 30.07.2024.
//

import Foundation
import SwiftUI

struct SubButtonText: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
    }

}
