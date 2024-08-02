//
//  LoginView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM: LoginViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedObject var globalDatas: GlobalDatas
    init(globalDatas: GlobalDatas) {
        self._loginVM = StateObject(wrappedValue: LoginViewModel(globalDatas: globalDatas))
        self._globalDatas = ObservedObject(wrappedValue: globalDatas)
    }
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .center, spacing: .dynamicHeight(height: 0.025)) {
                        EmailAndPasswordFields(loginVM: loginVM)
                        LoginButtonView(loginVM: loginVM, globalDatas: globalDatas)
                        Spacer()
                        DividerView()
                        Spacer()
                        SocilLoginButtons(loginVM: loginVM)
                        Spacer()
                        TermsAndConditionsWarning()
                        Spacer()
                    }
                    .pagePadding()
                    .vPadding(.medium2)
                    .padding(
                        .top,
                        globalDatas.isKeyboardVisible
                            ? globalDatas.keyboardHeight / 2
                            : .dynamicHeight(height: 0.025)
                    )
                    .navigationDestination(isPresented: $loginVM.isRedirectToRegister) {
                        RegisterView(globalDatas: globalDatas)
                            .navigationBarBackButtonHidden()
                            .environmentObject(globalDatas)
                    }
                }
                .frame(height: .dynamicHeight(height: 0.9))

            }
            .onReceive(globalDatas.keyboardWillShowPublisher) { notification in
                globalDatas.isKeyboardVisible = true
                if let keyboardFrame = notification.userInfo?[
                    UIResponder.keyboardFrameEndUserInfoKey
                ] as? CGRect {
                    globalDatas.keyboardHeight = keyboardFrame.height
                }
            }
            .onReceive(globalDatas.keyboardWillHidePublisher) { _ in
                globalDatas.isKeyboardVisible = false
                globalDatas.keyboardHeight = 0
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "xmark")
                            .font(.footnote)
                            .onTapGesture {
                                dismiss()
                            }
                        Spacer()
                        TitleText(title: "Log in or sign up")
                            .foregroundStyle(.primary)
                        Spacer()
                        IndicatorView(isLoading: $globalDatas.isLoading)
                    }
                    .hPadding()
                    .frame(width: .dynamicWidth(width: 1))
                }
            })
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.cWhite, for: .automatic)

        }
    }
}

#Preview {
    LoginView(globalDatas: GlobalDatas())
}

private struct ErrorMessageView: View {
    @ObservedObject var loginVM: LoginViewModel
    var body: some View {
        VStack {
            if !loginVM.isFieldsValidate && !loginVM.errorMessage.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundStyle(.red)
                    SubText(title: loginVM.errorMessage)
                        .foregroundStyle(.pink)
                        .frame(height: .dynamicHeight(height: 0.01))
                }
            }
        }
    }
}

private struct EmailAndPasswordFields: View {
    @ObservedObject var loginVM: LoginViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            EmailField(emailValue: $loginVM.emailValue)
            PasswordField(passwordValue: $loginVM.passwordValue)
                .padding(.bottom, .dynamicHeight(height: 0.025))
            VStack(alignment: .leading) {
                ErrorMessageView(loginVM: loginVM)
                SubText(title: "We'll send you an email to verify your account.")
                    .foregroundStyle(.gray)
            }
            .frame(height: .dynamicHeight(height: 0.035))

        }
    }
}

private struct LoginButtonView: View {
    @ObservedObject var loginVM: LoginViewModel
    @ObservedObject var globalDatas: GlobalDatas
    var body: some View {
        VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.015)) {
            HStack {
                Spacer()
                Button(
                    action: {
                        Task {
                            let response = await loginVM.login()
                            if response {
                                globalDatas.closeLoginModal()
                            }
                        }
                    },
                    label: {
                        HStack {
                            Spacer()
                            Text("Continue")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundStyle(.cWhite)
                                .vPadding(.medium)
                            Spacer()
                        }
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    }
                )
                Spacer()
            }
            SubButtonText(title: "Forgot password?")
                .foregroundStyle(.cPink)
        }
        .padding(.top, .dynamicHeight(height: 0.025))

    }
}

private struct DividerView: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: .dynamicWidth(width: 0.4), height: 0.5)
                .background(.gray)

            SubText(title: "or")
                .frame(width: .dynamicWidth(width: 0.06))

            Rectangle()
                .frame(width: .dynamicWidth(width: 0.4), height: 0.5)
                .background(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct DontHaveAnAccountView: View {
    @ObservedObject var loginVM: LoginViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Hesabın yok mu?")
                    .font(.caption)
                Button {
                    loginVM.isRedirectToRegister = true
                } label: {
                    SubButtonText(title: "Kayıt ol")
                        .underline()
                        .foregroundStyle(.cPink)
                }
                Spacer()
            }

        }
    }
}

private struct SocilLoginButtons: View {
    @ObservedObject var loginVM: LoginViewModel
    var body: some View {
        VStack {
            SocialLoginButton(
                image: .email,
                title: "Continue with email",
                titleColor: .cWhite,
                bgColor: .blue,
                onTap: {
                    withAnimation(.snappy) {
                        loginVM.isRedirectToRegister = true
                    }
                }
            )
            SocialLoginButton(
                image: .apple,
                title: "Continue with Apple",
                titleColor: .primary,
                bgColor: .secondary,
                onTap: { loginVM.isRedirectToRegister = true }
            )
            SocialLoginButton(
                image: .google,
                title: "Continue with Google",
                titleColor: .black,
                bgColor: .cPink,
                onTap: { loginVM.isRedirectToRegister = true }
            )
            SocialLoginButton(
                image: .icFacebook,
                title: "Continue with Facebook",
                titleColor: .cWhite,
                bgColor: .blue,
                onTap: { loginVM.isRedirectToRegister = true }
            )
        }
    }
}

struct TermsAndConditionsWarning: View {
    var body: some View {
        VStack {
            SubText(title: "By continuing, you agree to our")
                .foregroundStyle(.gray)
            HStack {
                Button(
                    action: {},
                    label: {
                        SubTitleText(title: "Terms and Conditions")
                            .foregroundStyle(.cPink)
                    }
                )
                SubText(title: "and have read")
                    .foregroundStyle(.gray)
            }
            HStack {
                SubText(title: "our")
                    .foregroundStyle(.gray)
                Button(
                    action: {},
                    label: {
                        SubTitleText(title: "Privacy Policy")
                            .foregroundStyle(.cPink)
                    }
                )
            }
        }
    }
}
