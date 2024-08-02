//
//  ListingItemImageContainer.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import SwiftUI

struct ListingItemImageContainer: View {
    let images: [String]
    let rentedPlace: RentPlaceModel
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView {
                ForEach(images, id: \.description) { item in
                    Image(item)
                        .resizable()
                }
            }
            .tabViewStyle(.page)
            FavouriteButton(rentedPlace: rentedPlace)
                .padding(.top, 10)
        }
    }
}

//#Preview {
//    ListingItemImageContainer(images: RentPlaceModel.dummyItem.imageUrls)
//}
