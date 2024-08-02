//
//  RegisterService.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import FirebaseFirestore
import Foundation

protocol IRegisterService {
    func register(user: UserModel) async -> String?
}

final class RegisterService: IRegisterService {

    private let userCollection = FirebaseManager.Fires.instance.collection(
        FirebaseCollections.users.rawValue
    )
    private let fbAuth = FirebaseManager.Authh.instance.auth()

    func register(user: UserModel) async -> String? {

        guard user.email != nil, user.password != nil else { return nil }

        let result = try? await fbAuth.createUser(withEmail: user.email!, password: user.password!)

        guard let userId = result?.user.uid else {
            print("Auth register failed user uid returned as null")
            return nil
        }
        let registerUserModel = FirebaseUserModel(
            id: userId,
            name: user.name ?? "",
            email: user.email!,
            password: user.password!,
            birthDate: Timestamp(date: user.birthDate ?? Date())
        )
        insertUserToFirestore(user: registerUserModel)
        return userId
    }

    private func insertUserToFirestore(user: FirebaseUserModel) {
        userCollection.document(user.id).setData(user.asDictionary())
    }

}
