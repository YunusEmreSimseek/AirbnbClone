//
//  FavouriteButton.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import Foundation
import SwiftUI

struct FavouriteButton: View {
    @StateObject var wishlistVM: WishlistViewModel = WishlistViewModel.instance
    let rentedPlace: RentPlaceModel
    var body: some View {
        Button(
            action: {
                if wishlistVM.isContain(rentedPlace) {
                    wishlistVM.removePlaceFromWishlist(rentedPlace)
                }
                else {
                    wishlistVM.addPlaceInWishlist(rentedPlace)
                }

            },
            label: {
                if wishlistVM.isContain(rentedPlace) {
                    Image(systemName: "heart.fill")
                        .padding()
                        .font(.title2)
                        .foregroundStyle(.cBlack)
                }
                else {
                    Image(systemName: "heart")
                        .padding()
                        .font(.title2)
                        .foregroundStyle(.cBlack)
                }

            }
        )
    }
}
