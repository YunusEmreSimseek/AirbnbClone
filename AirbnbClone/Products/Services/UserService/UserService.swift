//
//  UserService.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 29.07.2024.
//

import Combine
import FirebaseFirestore
import Foundation

protocol IUserService {
    func fetchUser(userId: String) async throws -> UserModel?
}

final class UserService: IUserService {

    private let userCollection = FirebaseManager.Fires.instance.collection(
        FirebaseCollections.users.rawValue
    )

    //    func fetchUser(id: String, onComplete: @escaping ((UserModel?) -> Void)) {
    //
    //        userCollection.document(id)
    //            .getDocument { (document, error) in
    //                guard document?.exists != nil && document!.exists else {
    //                    print("Document not found")
    //                    return
    //                }
    //                let user = try? document?.data(as: UserModel.self)
    //                guard user != nil else {
    //                    print("User not found")
    //                    return
    //                }
    //                print("service user: \(user.debugDescription)")
    //                onComplete(user)
    //
    //            }
    //
    //    }

    func fetchUser(userId: String) async throws -> UserModel? {
        let document = try await userCollection.document(userId).getDocument()
        guard document.exists else {
            return nil
        }
        let firebaseUser = try document.data(as: FirebaseUserModel.self)
        let user = UserModel(
            id: firebaseUser.id,
            name: firebaseUser.name,
            email: firebaseUser.email,
            password: firebaseUser.password,
            birthDate: firebaseUser.birthDate.dateValue()
        )
        //        let user = try document.data(as: UserModel.self)
        print("service user: \(user)")
        return user

    }
}
