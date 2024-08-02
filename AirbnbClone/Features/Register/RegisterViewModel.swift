//
//  RegisterViewModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import Foundation
import SwiftUI

final class RegisterViewModel: ObservableObject {
    @ObservedObject var globalDatas: GlobalDatas
    @Published var firstNameValue: String = ""
    @Published var secondNameValue: String = ""
    @Published var emailValue: String = ""
    @Published var passwordValue: String = ""
    @Published var errorMessage: String = ""
    @Published var dateValue: String = ""
    @Published var isButtonDisabled: Bool = true
    @Published var isFormValidate: Bool = false
    @Published var showDatePicker: Bool = false
    @Published var isDateSelected: Bool = false
    @Published var selectedDate: Date = Date()
    private let registerService: IRegisterService
    private let userService: IUserService

    init(globalDatas: GlobalDatas) {
        self.globalDatas = globalDatas
        registerService = RegisterService()
        userService = UserService()
    }

    func checkForm() {
        guard !firstNameValue.trimmingCharacters(in: .whitespaces).isEmpty,
            !secondNameValue.trimmingCharacters(in: .whitespaces).isEmpty,
            !emailValue.trimmingCharacters(in: .whitespaces).isEmpty,
            !passwordValue.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Lütfen alanları boş bırakmayınız."
            isFormValidate = false
            isButtonDisabled = true
            return
        }

        guard emailValue.isEmail() else {
            errorMessage = "Lütfen geçerli bir email adresi giriniz."
            isFormValidate = false
            isButtonDisabled = true
            return
        }

        guard passwordValue.isPasswordValid() else {
            errorMessage = "Şifreniz en az 6 karakter olmalıdır."
            isFormValidate = false
            isButtonDisabled = true
            return
        }

        errorMessage = ""
        isFormValidate = true
        isButtonDisabled = false
    }

    func register() async {
        checkForm()
        guard isFormValidate else { return }
        globalDatas.startLoading()
        let userModel = UserModel(
            id: nil,
            name: "\(firstNameValue) \(secondNameValue)",
            email: emailValue,
            password: passwordValue,
            birthDate: selectedDate
        )
        let result = await registerService.register(user: userModel)
        guard result != nil else {
            return
        }
        let user = try? await userService.fetchUser(
            userId: result!
        )
        guard user != nil else {
            return
        }
        print("user: \(user!)")
        globalDatas.setCurrentUser(user!)
        globalDatas.endLoading()
        globalDatas.closeLoginModal()
    }

    func attributedString() -> AttributedString {
        var string = AttributedString(
            "Make sure this matches the name on your government ID. If you go by another name, you can add a preferred first name."
        )

        if let range = string.range(of: "preferred first name") {
            string[range].underlineStyle = .single
            string[range].foregroundColor = .cBlack
        }
        return string
    }

    func attributedString2() -> AttributedString {
        var string = AttributedString(
            "By selecting Agree and continue. i agree to Airbnb's Terms of Service, Payments Terms of Service and Nondiscrimination Policy and acknowledge the Privacy Policy."
        )
        if let range1 = string.range(of: "Terms of Service, Payments Terms of Service") {
            string[range1].underlineStyle = .single
            string[range1].foregroundColor = .cBlack
        }
        if let range2 = string.range(of: "Nondiscrimination Policy") {
            string[range2].underlineStyle = .single
            string[range2].foregroundColor = .cBlack
        }
        if let range3 = string.range(of: "Privacy Policy") {
            string[range3].underlineStyle = .single
            string[range3].foregroundColor = .cBlack
        }
        return string
    }
}
