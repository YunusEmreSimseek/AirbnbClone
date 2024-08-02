//
//  GlobalDatas.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import FirebaseAuth
import Foundation
import SwiftUI

final class GlobalDatas: ObservableObject {
    @Published var isShowLoginModal: Bool = false
    @Published var isLoading: Bool = false
    @Published var currentUser: UserModel? = nil
    @Published var hasCurrentUser: Bool = false
    @Published var isKeyboardVisible: Bool = false
    @Published var keyboardHeight: CGFloat = 0
    var keyboardWillShowPublisher = NotificationCenter.default.publisher(
        for: UIResponder.keyboardWillShowNotification
    )
    var keyboardWillHidePublisher = NotificationCenter.default.publisher(
        for: UIResponder.keyboardWillHideNotification
    )

    func showLoginModal() {
        isShowLoginModal = true
    }

    func closeLoginModal() {
        isShowLoginModal = false
    }

    func startLoading() {
        isLoading = true
    }

    func endLoading() {
        isLoading = false
    }

    func setCurrentUser(_ user: UserModel) {
        currentUser = user
        hasCurrentUser = true
    }
}
