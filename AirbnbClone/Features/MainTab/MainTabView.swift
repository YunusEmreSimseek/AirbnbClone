//
//  MainTabView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var globalDatas: GlobalDatas
    @StateObject var mainTabVM: MainTabViewModel
    init(globalDatas: GlobalDatas) {
        _mainTabVM = StateObject(wrappedValue: MainTabViewModel(globalDatas: globalDatas))
        _globalDatas = ObservedObject(wrappedValue: globalDatas)
    }
    var body: some View {
        TabView {
            ForEach(TabItems.tabList, id: \.hashValue) { item in
                item.toModel().page
                    .tabItem {
                        Image(systemName: item.toModel().label.iconName)
                        Text(item.toModel().label.title)
                    }
                    .environmentObject(globalDatas)
            }
        }
        .onAppear {
            Task {
                                await self.mainTabVM.chechUserLogin()
            }
        }
        .sheet(
            isPresented: self.$globalDatas.isShowLoginModal,
            content: {
                LoginView(globalDatas: globalDatas)
            }
        )
    }
}

private enum TabItems {
    case explore
    case wishlist
    case profile

    func toModel() -> TabItemsModel {
        if case .explore = self {
            return TabItemsModel(
                page: AnyView(ExploreView()),
                //                page: AnyView(ProfileView()),
                label: TabLabel(title: "Explore", iconName: "magnifyingglass")
            )
        }
        else if case .wishlist = self {
            return TabItemsModel(
                page: AnyView(WishlistView()),
                label: TabLabel(title: "Wishlist", iconName: "heart")
            )
        }
        else if case .profile = self {
            return TabItemsModel(
                page: AnyView(ProfileView()),
                label: TabLabel(title: "Profile", iconName: "person.crop.circle")
            )
        }
        else {
            return TabItemsModel(
                page: AnyView(ExploreView()),
                label: TabLabel(title: "Explore", iconName: "glass")
            )
        }
    }
}

extension TabItems {
    static let tabList = [
        TabItems.explore,
        TabItems.wishlist,
        TabItems.profile,
    ]
}

private struct TabItemsModel: Identifiable {
    let id = UUID()
    let page: AnyView
    let label: TabLabel

}

private struct TabLabel {
    let title: String
    let iconName: String
}

#Preview {
    MainTabView(globalDatas: GlobalDatas())
}
