//
//  MainTabViewModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 2.08.2024.
//

import Foundation
import SwiftUI

final class MainTabViewModel: ObservableObject {
    @ObservedObject var globalDatas: GlobalDatas
    let authService: IAuthService = AuthService()
    let userService: IUserService = UserService()

    init(globalDatas: GlobalDatas) {
        self.globalDatas = globalDatas
    }

    func chechUserLogin() async {
        let response = authService.checkUserLogin()
        guard response != nil else {
            globalDatas.showLoginModal()
            return
        }
        globalDatas.startLoading()
        let user = try? await userService.fetchUser(userId: response!)
        guard user != nil else {
            globalDatas.showLoginModal()
            globalDatas.endLoading()
            return
        }
        globalDatas.setCurrentUser(user!)
        globalDatas.endLoading()
        globalDatas.closeLoginModal()
    }
}
