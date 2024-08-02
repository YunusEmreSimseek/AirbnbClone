//
//  WishlistView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import SwiftUI

struct WishlistView: View {
    @StateObject private var wishlistVM: WishlistViewModel = WishlistViewModel.instance
    @EnvironmentObject var globalDatas: GlobalDatas
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.05)) {
                PageTitleText(title: "Wishlist")

                if globalDatas.hasCurrentUser {
                    BodyView(rentedPlaces: $wishlistVM.wishlistedPlaces, wishlistVM: wishlistVM)
                }
                else {
                    FirstLoginView(globalDatas: globalDatas)
                }
            }
            .tabBarPagePadding()
        }
    }
}

#Preview {
    WishlistView()
}

private struct FirstLoginView: View {
    @ObservedObject var globalDatas: GlobalDatas
    var body: some View {
        VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.05)) {
            VStack(alignment: .leading, spacing: .dynamicHeight(height: 0.015)) {
                Text("Log in to  view your wishlist")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(
                    "You can create, view or edit wishlist once you've loged in"
                )
                .foregroundStyle(.gray)
            }

            ElevatedButton(title: "Log in") {
                globalDatas.showLoginModal()
            }
            Spacer()
        }
    }
}

private struct BodyView: View {
    @Binding var rentedPlaces: [RentPlaceModel]
    @ObservedObject var wishlistVM: WishlistViewModel
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(rentedPlaces, id: \.id) { place in
                    NavigationLink {
                        RentedPlaceDetails(rentedPlace: place)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        RentedPlacePreview(rentedPlace: place)
                            .frame(height: 420)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
    }
}
