//
//  RentedPlaceDetails.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import MapKit
import SwiftUI

private let dummyItem = RentPlaceModel.dummyItem
struct RentedPlaceDetails: View {
    let rentedPlace: RentPlaceModel
    @State private var cameraPosition: MapCameraPosition

    init(rentedPlace: RentPlaceModel) {
        self.rentedPlace = rentedPlace

        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(rentedPlace.latitude, rentedPlace.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )

        self._cameraPosition = State(initialValue: .region(region))
    }

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                ListingItemImageContainer(
                    images: rentedPlace.imageUrls,
                    rentedPlace: rentedPlace
                )
                .frame(height: 320)
                BackButton()
            }
            VStack(alignment: .leading, spacing: 30) {
                ItemMainDetailView(rentedPlace: rentedPlace)
                UserInformation(rentedPlace: rentedPlace)
                FeatureView(features: rentedPlace.features)
                ItemBedroomsChoiceView(bedrooms: rentedPlace.numberOfBedrooms)
                ItemOffersView(amenities: rentedPlace.amenities)
                ItemLocationView(cameraPosition: $cameraPosition)
            }
            .padding(.horizontal)
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .leading)

        }
        .padding(.bottom, 60)
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            BottomNavigationBarView()

        }

    }

}

#Preview {
    RentedPlaceDetails(rentedPlace: RentPlaceModel.dummyItem)
}

struct UserInformation: View {
    let rentedPlace: RentPlaceModel
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Entire villa hosted by \(rentedPlace.ownerName)")
                    .frame(width: 200, alignment: .leading)
                    .font(.callout)
                    .fontWeight(.semibold)
                Text(
                    "\(rentedPlace.numberOfGuests) guests - \(rentedPlace.numberOfBedrooms) bedrooms - \(rentedPlace.numberOfBeds) beds - \(rentedPlace.numberOfBathrooms) baths"
                )
                .frame(maxWidth: 250, alignment: .leading)
            }
            .frame(minWidth: 250)
            Spacer()
            Image(rentedPlace.ownerImageUrl)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 100, maxHeight: 70)
                .clipShape(Circle())

        }

    }
}

private struct FeatureView: View {
    let features: [PlaceFeatures]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(features, id: \.id) { feature in
                HStack {
                    Image(systemName: feature.imageName)
                        .font(.callout)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(feature.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(feature.suubTitle)
                    }
                }
            }
        }
    }
}

struct ItemBedroomsChoiceView: View {
    let bedrooms: Int
    var body: some View {
        VStack(
            alignment: .leading,
            content: {
                Text("Where you'll sleep")
                    .font(.callout)
                    .fontWeight(.semibold)
                ScrollView(
                    .horizontal,
                    content: {
                        HStack(
                            alignment: .center,
                            content: {

                                ForEach(0...bedrooms - 1, id: \.description) { item in
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 100, height: 100)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(lineWidth: 1)
                                            )
                                            .foregroundStyle(.black)
                                        Image(systemName: "bed.double")
                                            .font(.subheadline)
                                        Text("Bedroom \(item+1)")
                                            .padding(.top, 30)
                                    }

                                }
                            }
                        )

                    }
                )
            }
        )

    }
}

private struct ItemOffersView: View {
    let amenities: [PlaceAmenities]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What this place offers")
                .font(.callout)
                .fontWeight(.semibold)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(amenities, id: \.id) { amenitie in
                    HStack(spacing: 8) {
                        Image(systemName: amenitie.imageName)
                            .font(.title3)
                        Text(amenitie.title)
                            .font(.subheadline)

                    }
                }
            }
        }
    }
}

private struct ItemMainDetailView: View {
    let rentedPlace: RentPlaceModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(rentedPlace.title)
                .font(.title)
                .fontWeight(.semibold)
            VStack(alignment: .leading) {
                HStack {
                    ListingItemRateRow(rate: rentedPlace.rating.description)
                    Text(" - ")
                    Text("28 reviews")
                        .underline()
                        .fontWeight(.semibold)

                }
                Text("\(rentedPlace.city), \(rentedPlace.state)")
            }

        }
    }
}

private struct ItemLocationView: View {
    @Binding var cameraPosition: MapCameraPosition
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Where you'll be")
                .font(.callout)
                .fontWeight(.semibold)
            Map(position: $cameraPosition)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct BottomNavigationBarView: View {
    var body: some View {
        VStack {
            //            Divider()
            //                .padding(.bottom)

            HStack {
                VStack(alignment: .leading) {
                    Text("$500")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("Total befoore taxes")
                        .font(.footnote)
                    Text("Oct 15-20")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .underline()
                }
                .foregroundStyle(.primary)
                Spacer()
                Button(
                    action: {},
                    label: {
                        Text("Reserve")
                            .foregroundStyle(.white)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(width: 140, height: 50)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                )
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 10)

        }
        .background(.cWhite)
    }
}
