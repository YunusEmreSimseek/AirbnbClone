//
//  UserModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 29.07.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userModel = try? JSONDecoder().decode(UserModel.self, from: jsonData)

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let id: String?
    let name, email, password: String?
    let birthDate: Date?

    func copyWith(
        name: String?,
        email: String?,
        password: String?,
        birthDate: Date?
    ) -> UserModel {
        return UserModel(
            id: self.id,
            name: name ?? self.name,
            email: email ?? self.email,
            password: password ?? self.password,
            birthDate: birthDate ?? self.birthDate
        )
    }
}
