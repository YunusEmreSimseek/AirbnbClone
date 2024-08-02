//
//  AirbnbCloneApp.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//
import FirebaseCore
import SwiftUI

@main
struct AirbnbCloneApp: App {
    @StateObject var globalDatas: GlobalDatas = GlobalDatas()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainTabView(globalDatas: globalDatas)
        }

    }
}
