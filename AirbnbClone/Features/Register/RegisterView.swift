//
//  RegisterView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import SwiftUI

struct RegisterView: View {
    init(globalDatas: GlobalDatas) {
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(globalDatas: globalDatas))
        self._globalDatas = ObservedObject(wrappedValue: globalDatas)
    }
    @StateObject var registerVM: RegisterViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedObject var globalDatas: GlobalDatas

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.04)) {
                        LegalNameColumn(registerVM: registerVM)
                        DateOfBirthColumn(registerVM: registerVM)
                        EmailColumn(registerVM: registerVM)
                        PasswordColumn(registerVM: registerVM)
                        PrivacyColumn(registerVM: registerVM)
                        RegisterButtonView(registerVM: registerVM)
                    }
                    .pagePadding()
                    .vPadding(.normal)
                    .padding(
                        .top,
                        globalDatas.isKeyboardVisible
                            ? globalDatas.keyboardHeight / 2 : .dynamicHeight(height: 0.025)
                    )
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
                        Image(systemName: "chevron.left")
                            .font(.footnote)
                            .onTapGesture {
                                dismiss()
                            }
                        Spacer()
                        TitleText(title: "Finish signing up")
                            .foregroundStyle(.primary)
                        Spacer()
                        IndicatorView(isLoading: $globalDatas.isLoading)
                    }
                    .hPadding()
                    .frame(width: .dynamicWidth(width: 1))
                }

            }
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.cWhite, for: .automatic)
        }

    }

}

#Preview {
    RegisterView(globalDatas: GlobalDatas())
}

private struct ErrorMessageView: View {
    @ObservedObject var registerVM: RegisterViewModel
    let screenSize = GlobalScreenSize.size
    var body: some View {
        VStack {
            if !registerVM.isFormValidate {
                SubText(title: registerVM.errorMessage)
                    .foregroundStyle(.pink)
                    .frame(height: screenSize.dynamicHeight(height: 0.02))

            }
            else {
                Text("")
                    .frame(height: screenSize.dynamicHeight(height: 0.02))

            }
        }
    }
}

private struct LegalNameColumn: View {
    @ObservedObject var registerVM: RegisterViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Legal name")
                .fontWeight(.semibold)
                .padding(.bottom, .dynamicHeight(height: 0.025))
            TextField("First name on ID", text: $registerVM.firstNameValue)
                .modifier(TextFieldModifier())
            TextField("Last name on ID", text: $registerVM.secondNameValue)
                .modifier(TextFieldModifier())
                .padding(.bottom, .dynamicHeight(height: 0.015))
            Text(registerVM.attributedString())
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

private struct DateOfBirthColumn: View {
    @ObservedObject var registerVM: RegisterViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Date of birth")
                .fontWeight(.semibold)
                .padding(.bottom, .dynamicHeight(height: 0.025))
            HStack {
                Text(
                    registerVM.isDateSelected
                        ? "\(registerVM.selectedDate.formatted(date: .abbreviated, time: .omitted))"
                        : "Birthday (mm/dd/yyyy)"
                )
                .font(.footnote)
                .foregroundStyle(
                    registerVM.isDateSelected
                        ? .cBlack
                        : .gray
                )
                .onTapGesture {
                    registerVM.showDatePicker = true
                }

                Spacer()
            }
            .modifier(TextFieldModifier())
            .padding(.bottom, .dynamicHeight(height: 0.015))
            SubText(
                title:
                    "To sign up, you need to be at least 18. Yout birthday won't be shared with other people who use Airbnb."
            )
            .foregroundStyle(.gray)
        }
        .sheet(
            isPresented: $registerVM.showDatePicker,
            content: {
                VStack {
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                registerVM.showDatePicker = false
                                registerVM.isDateSelected = true
                            },
                            label: {
                                Text("Next")
                                    .font(.subheadline)
                                    .underline()
                            }
                        )
                    }
                    .hPadding()
                    HStack {
                        DatePicker(
                            "",
                            selection: $registerVM.selectedDate,
                            displayedComponents: .date
                        )
                        .presentationDetents([.height(.dynamicHeight(height: 0.4))])
                        .datePickerStyle(.wheel)
                        .labelsHidden()

                    }
                    .frame(width: .infinity)
                }
            }
        )
    }
}

private struct EmailColumn: View {
    @ObservedObject var registerVM: RegisterViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Email")
                .fontWeight(.semibold)
                .padding(.bottom, .dynamicHeight(height: 0.025))
            TextField("Email", text: $registerVM.emailValue)
                .modifier(TextFieldModifier())
                .padding(.bottom, .dynamicHeight(height: 0.015))
            SubText(
                title:
                    "We'll email you trip confirmations and receipts."
            )
            .foregroundStyle(.gray)
        }
    }
}

private struct PasswordColumn: View {
    @ObservedObject var registerVM: RegisterViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Password")
                .fontWeight(.semibold)
                .padding(.bottom, .dynamicHeight(height: 0.025))
            SecureField("Password", text: $registerVM.passwordValue)
                .modifier(TextFieldModifier())
        }
    }
}

private struct PrivacyColumn: View {
    @ObservedObject var registerVM: RegisterViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(registerVM.attributedString2())
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

private struct RegisterButtonView: View {
    @ObservedObject var registerVM: RegisterViewModel
    var body: some View {
        VStack {
            Button(
                action: {
                    Task {
                        await registerVM.register()
                    }
                },
                label: {
                    HStack {
                        Spacer()
                        Text("Agree and continue")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.cWhite)
                            .vPadding(.medium)
                        Spacer()
                    }
                    .foregroundStyle(.cWhite)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.cBlack)
                    }
                }
            )
        }
    }
}
