//
//  LoginViewModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {

    init(globalDatas: GlobalDatas) {
        self.globalDatas = globalDatas
        self.authService = AuthService()
        self.userService = UserService()
    }
    @ObservedObject var globalDatas: GlobalDatas
    @Published var emailValue: String = ""
    @Published var passwordValue: String = ""
    @Published var errorMessage: String = ""
    @Published var isFieldsValidate: Bool = false
    @Published var isButonDisabled: Bool = true
    @Published var isRedirectToHome: Bool = false
    @Published var isRedirectToRegister: Bool = false
    private let authService: IAuthService
    private let userService: IUserService

    func checkField() {
        guard !emailValue.trimmingCharacters(in: .whitespaces).isEmpty,
            !passwordValue.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Lütfen alanları boş bırakmayınız."
            isFieldsValidate = false
            isButonDisabled = true
            return
        }

        guard emailValue.isEmail() else {
            errorMessage = "Lütfen geçerli bir email adresi giriniz."
            isFieldsValidate = false
            isButonDisabled = true
            return
        }
        errorMessage = ""
        isFieldsValidate = true
        isButonDisabled = false
    }
    func login() async -> Bool {
        checkField()
        guard isFieldsValidate else { return false }
        globalDatas.startLoading()
        let loginUserModel = LoginUserModel(email: emailValue, password: passwordValue)
        let responseId = await authService.login(user: loginUserModel)
        guard responseId != nil else {
            globalDatas.endLoading()
            return false
        }
        let user = try? await userService.fetchUser(userId: responseId!)
        guard user != nil else {
            globalDatas.endLoading()
            return false
        }
        globalDatas.setCurrentUser(user!)
        globalDatas.endLoading()
        isRedirectToHome = true
        return true
    }

}
