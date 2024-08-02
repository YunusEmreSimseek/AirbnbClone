//
//  ProfileViewModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 29.07.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    private let authService: IAuthService

    init() {
        authService = AuthService()
    }

    func signOut() {
        authService.signOut()
    }

}
