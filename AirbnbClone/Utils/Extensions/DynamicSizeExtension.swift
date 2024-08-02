//
//  DynamicSizeExtension.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation

extension CGSize {
    /// Dynamic Height by device
    /// - Parameter height: Percent value
    /// - Returns: Calculated value for device height
    func dynamicHeight(height: Double) -> Double {
        return self.height * height
    }

    /// Dynamic Width by device
    /// - Parameter Width: Percent value
    /// - Returns: Calculated value for device Width
    func dynamicWidth(width: Double) -> Double {
        return self.width * width
    }
}

extension CGFloat {
    static private let screenSize = GlobalScreenSize.size
    static func dynamicHeight(height: Double) -> Double {
        return screenSize.height * height
    }

    static func dynamicWidth(width: Double) -> Double {
        return screenSize.width * width
    }
}
