//
//  FirebaseUserModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 2.08.2024.
//

import FirebaseFirestore
import Foundation

struct FirebaseUserModel: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let birthDate: Timestamp
}
