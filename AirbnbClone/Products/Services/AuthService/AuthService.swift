//
//  LoginService.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import FirebaseAuth
import Foundation

protocol IAuthService {
    func login(user: LoginUserModel) async -> String?
    func checkUserLogin() -> String?
    func signOut()

}

final class AuthService: IAuthService {
    private let auth = FirebaseManager.Authh.instance.auth()

    func login(user: LoginUserModel) async -> String? {

        let response = try? await auth.signIn(withEmail: user.email, password: user.password)
        guard response?.user.uid != nil else {
            print("Auth login failed user uid returned as null")
            return nil
        }
        return response?.user.uid
    }

    func checkUserLogin() -> String? {
        if auth.currentUser != nil {
            print("currentUser : \(auth.currentUser!.email ?? "")")
            print("currentUser : \(auth.currentUser!.uid)")
            return auth.currentUser?.uid
        }
        print("currentUser : not found")
        return nil
    }

    func signOut() {
        try? auth.signOut()
        print("currentUser : \(auth.currentUser?.email ?? "")")
    }

}
