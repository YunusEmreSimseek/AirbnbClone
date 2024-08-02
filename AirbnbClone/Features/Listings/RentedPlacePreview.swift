//
//  RentedPlacePreview.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import SwiftUI

private let dummyItem2 = ListingItemModel.item
private let dummyItem = RentPlaceModel.dummyItem

struct RentedPlacePreview: View {
    let rentedPlace: RentPlaceModel
    var body: some View {
        VStack(spacing: 8) {
            ListingItemImageContainer(
                images: rentedPlace.imageUrls,
                rentedPlace: rentedPlace
            )
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            ItemDetails(rentedPlace: rentedPlace)
        }

    }
}

private struct ItemDetails: View {
    let rentedPlace: RentPlaceModel
    var body: some View {
        HStack(alignment: .top) {
            // Details
            VStack(
                alignment: .leading,
                content: {
                    Text("\(rentedPlace.city), \(rentedPlace.state)")
                        .fontWeight(.bold)
                        .foregroundStyle(.cBlack)
                    Text(dummyItem2.distance)
                        .foregroundStyle(.gray)
                    Text(dummyItem2.date)
                        .foregroundStyle(.gray)
                    HStack(spacing: 4) {
                        Text("$\(rentedPlace.pricePerNight.description)")
                        Text("night")
                    }
                    .foregroundStyle(.cBlack)

                }
            )
            Spacer()

            // Rating

            ListingItemRateRow(rate: rentedPlace.rating.description)
        }
        .font(.footnote)
    }
}

//#Preview {
//    ListingItemView()
//        .padding()
//}
