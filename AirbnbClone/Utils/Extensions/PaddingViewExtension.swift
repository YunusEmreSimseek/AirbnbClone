//
//  PaddingViewExtension.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation
import SwiftUI

extension View {

    func hPadding(_ value: Paddings = Paddings.normal) -> some View {
        return self.padding(.horizontal, value.rawValue)
    }

    func vPadding(_ value: Paddings = Paddings.normal) -> some View {
        return self.padding(.vertical, value.rawValue)
    }

    func allPadding(_ value: Paddings = Paddings.medium2) -> some View {
        return self.padding(.all, value.rawValue)
    }

    func pagePadding() -> some View {
        return self.padding(
            EdgeInsets(
                top: Paddings.medium.rawValue,
                leading: Paddings.medium1.rawValue,
                bottom: Paddings.medium.rawValue,
                trailing: Paddings.medium1.rawValue
            )
        )
    }
    
    func tabBarPagePadding() -> some View {
        return self.padding(
            EdgeInsets(
                top: Paddings.medium.rawValue,
                leading: Paddings.medium1.rawValue,
                bottom: Paddings.low.rawValue,
                trailing: Paddings.medium1.rawValue
            )
        )
    }
    
    
}
