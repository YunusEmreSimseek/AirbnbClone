//
//  WisihlistViewModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import Foundation

final class WishlistViewModel: ObservableObject {
    
    private init(){}
    
    static let instance = WishlistViewModel()
    
    @Published var wishlistedPlaces: [RentPlaceModel] = []

    func addPlaceInWishlist(_ place: RentPlaceModel) {
        wishlistedPlaces.append(place)
    }

    func removePlaceFromWishlist(_ place: RentPlaceModel) {
        wishlistedPlaces.removeAll { rentedPlace in
            rentedPlace.id == place.id
        }
    }
    
    func isContain(_ place: RentPlaceModel) -> Bool {
        return wishlistedPlaces.contains { rentedPlace in
            place.id == rentedPlace.id
        }
    }
}
