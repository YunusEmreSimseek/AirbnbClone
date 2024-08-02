//
//  ProfileView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileVM: ProfileViewModel = ProfileViewModel()
    @EnvironmentObject var globalDatas: GlobalDatas
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                PageTitleText(title: "Profile")
                if globalDatas.hasCurrentUser {
                    Text("\(globalDatas.currentUser!.name ?? "")")
                        .font(.title)
                    Text("\(globalDatas.currentUser!.email ?? "")")
                        .font(.title2)
                    Text(
                        "\(globalDatas.currentUser!.birthDate?.formatted(date: .abbreviated, time: .omitted) ?? "")"
                    )
                    .font(.title2)
                    ProfileItemsColumn(profileVM: profileVM)
                    SignOutButton(profileVM: profileVM, globalDatas: globalDatas)
                }
                else {
                    TitleColumn()
                    Spacer()
                    LoginButtonView(globalDatas: globalDatas)
                        .padding(.bottom, .dynamicHeight(height: 0.02))
                    DontHaveAnAccountRow(globalDatas: globalDatas)
                    Spacer()
                    InfoView()
                    Spacer()
                    ProfileItemsColumn(profileVM: profileVM)
                }
            }
            .tabBarPagePadding()
//            .padding(.bottom,.dynamicHeight(height: 0.015))
        }
        .frame(height: .dynamicHeight(height: 0.9))
    }
}
#Preview {
    ProfileView()
        .environmentObject(GlobalDatas())
}

private struct ProfileOptionRowView: View {
    let model: ProfileOptionRowModel
    var body: some View {
        VStack {
            HStack(spacing: .dynamicHeight(height: 0.02)) {
                Image(systemName: model.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: .dynamicHeight(height: 0.03))
                Text(model.title)
                    .font(.body)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)

            }
            Divider()
        }
    }
}

private struct ProfileOptionRowModel {
    let imageName: String
    let title: String
}

extension ProfileOptionRowModel {
    static let items = [
        ProfileOptionRowModel(imageName: "gear", title: "Settings"),
        ProfileOptionRowModel(imageName: "accessibility", title: "Accessibility"),
        ProfileOptionRowModel(imageName: "questionmark.circle", title: "Visit the help center"),
    ]
}

private struct DontHaveAnAccountRow: View {
    @ObservedObject var globalDatas: GlobalDatas
    var body: some View {
        HStack {
            Text("Don't have an accout?")
            Button(
                action: { globalDatas.showLoginModal() },
                label: {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .underline()
                        .foregroundStyle(.cBlack)
                }
            )

        }
    }
}

private struct ProfileItemsColumn: View {
    @ObservedObject var profileVM: ProfileViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.025)) {
            ForEach(ProfileOptionRowModel.items, id: \.title) { item in
                ProfileOptionRowView(model: item)
            }
        }
    }
}

private struct TitleColumn: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Log in to start planning your next trip")
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
}

private struct SignOutButton: View {
    @ObservedObject var profileVM: ProfileViewModel
    @ObservedObject var globalDatas: GlobalDatas
    var body: some View {
        VStack {
            Button(
                action: {
                    profileVM.signOut()
                    globalDatas.hasCurrentUser = false
                    globalDatas.currentUser = nil
                    globalDatas.showLoginModal()
                },
                label: {
                    HStack {
                        Spacer()
                        Text("Sign Out")
                        Spacer()
                    }
                    .frame(width: 200)
                    .vPadding(.low)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.cBlack)

                }
            )
        }
    }
}

private struct LoginButtonView: View {
    @ObservedObject var globalDatas: GlobalDatas
    var body: some View {
        VStack {
            ElevatedButton(title: "Log in") {
                globalDatas.showLoginModal()
            }
        }
    }
}

private struct InfoView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.01)) {
                Text("Airbnb your place")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("It's simple to get set up and start earning.")
                    .foregroundStyle(.gray)
            }
            .frame(width: .dynamicWidth(width: 0.5))
            Spacer()
            Image(.home)
                .resizable()
                .scaledToFit()
                .frame(height: .dynamicHeight(height: 0.1))
            Spacer()
        }
        .frame(width: .infinity)
        .pagePadding()
        .background(.cWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 10)
    }
}
