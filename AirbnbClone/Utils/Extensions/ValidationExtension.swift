//
//  ValidationExtension.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        guard self.contains("@") && self.contains(".") else {
            return false
        }
        return true
    }

    func isPasswordValid() -> Bool {
        guard self.count >= 6 else {
            return false
        }
        return true
    }
}
