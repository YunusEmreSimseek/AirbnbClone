//
//  TitleText.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 1.08.2024.
//

import Foundation
import SwiftUI

struct TitleText: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
    }

}
