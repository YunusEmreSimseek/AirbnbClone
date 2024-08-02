//
//  ExploreViewModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import Foundation

final class ExploreViewModel: ObservableObject {
    @Published var rentedPlaces: [RentPlaceModel] = RentPlaceModel.dummyItems
    @Published var destination: String = ""

    func filterRentedPlaces() {
        let filteredPlaces = rentedPlaces.filter({
            $0.city.lowercased() == destination.lowercased()
                || $0.state.lowercased() == destination.lowercased()
        })

        self.rentedPlaces = filteredPlaces.isEmpty ? self.rentedPlaces : filteredPlaces
    }

    func removeFilterFromRentedPlaces() {
        rentedPlaces = RentPlaceModel.dummyItems
    }

    func changeDestination(_destination: String) {
        self.destination = _destination
    }
}
