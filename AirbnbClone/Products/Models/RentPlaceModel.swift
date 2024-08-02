//
//  RentHotelModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import Foundation

struct RentPlaceModel: Identifiable, Codable {
    let id: String
    let ownerUid: String
    let ownerName: String
    let ownerImageUrl: String
    let numberOfBedrooms: Int
    let numberOfBathrooms: Int
    let numberOfGuests: Int
    let numberOfBeds: Int
    var pricePerNight: Int
    let latitude: Double
    let longitude: Double
    var imageUrls: [String]
    let address: String
    let city: String
    let state: String
    let title: String
    var rating: Double
    var features: [PlaceFeatures]
    var amenities: [PlaceAmenities]
    let type: PlaceType
}

enum PlaceFeatures: Int, Codable, Identifiable, Hashable {
    case selfCheckIn
    case superHost

    var id: Int { return self.rawValue }

    var imageName: String {
        switch self {
            case .selfCheckIn:
                return "door.left.hand.open"
            case .superHost:
                return "medal"
        }
    }

    var title: String {
        switch self {
            case .selfCheckIn:
                return "Self check-in"
            case .superHost:
                return "Superhost"
        }
    }

    var suubTitle: String {
        switch self {
            case .selfCheckIn:
                return "Check yourself in with the keypad."
            case .superHost:
                return
                    "Superhosts are experienced, hihgly rated hosts who are commited to providing greate stars for guests."
        }
    }
}

enum PlaceAmenities: Int, Codable, Identifiable, Hashable {
    case pool
    case kitchen
    case wifi
    case laundry
    case tv
    case alarmSystem
    case office
    case balcony

    var id: Int { return self.rawValue }

    var title: String {
        switch self {
            case .pool:
                return "Pool"
            case .kitchen:
                return "Kitchen"
            case .wifi:
                return "Wifi"
            case .laundry:
                return "Laundry"
            case .tv:
                return "TV"
            case .alarmSystem:
                return "Alarm system"
            case .office:
                return "Office"
            case .balcony:
                return "Balcony"
        }
    }

    var imageName: String {
        switch self {
            case .pool:
                return "figure.pool.swim"
            case .kitchen:
                return "fork.knife"
            case .wifi:
                return "wifi"
            case .laundry:
                return "washer"
            case .tv:
                return "tv"
            case .alarmSystem:
                return "checkerboard.shield"
            case .office:
                return "pencil.and.ruler.fill"
            case .balcony:
                return "building"
        }
    }
}

enum PlaceType: Int, Codable, Identifiable, Hashable {
    case apartment
    case house
    case townHouse
    case villa

    var id: Int { return self.rawValue }

    var description: String {
        switch self {
            case .apartment:
                return "Apartment"
            case .house:
                return "House"
            case .townHouse:
                return "Townhouse"
            case .villa:
                return "Villa"
        }
    }

}

extension RentPlaceModel {

    static let dummyItem = RentPlaceModel(
        id: NSUUID().uuidString,
        ownerUid: "1",
        ownerName: "Emre Simsek",
        ownerImageUrl: "emre",
        numberOfBedrooms: 2,
        numberOfBathrooms: 1,
        numberOfGuests: 3,
        numberOfBeds: 2,
        pricePerNight: 200,
        latitude: 37.787994,
        longitude: -122.407437,
        imageUrls: ["a1", "a2", "a3"],
        address: "301 Howard St",
        city: "San Francisco",
        state: "CA",
        title: "Modern apartment in the heart of San Francisco",
        rating: 4.5,
        features: [.selfCheckIn, .superHost],
        amenities: [.pool, .kitchen, .wifi, .laundry, .tv, .alarmSystem, .office, .balcony],
        type: .apartment
    )

    static let dummyItems = [
        RentPlaceModel(
            id: NSUUID().uuidString,
            ownerUid: "1",
            ownerName: "Joe Smith",
            ownerImageUrl: "man1",
            numberOfBedrooms: 2,
            numberOfBathrooms: 1,
            numberOfGuests: 3,
            numberOfBeds: 2,
            pricePerNight: 200,
            latitude: 37.787994,
            longitude: -122.407437,
            imageUrls: ["a1", "a2", "a3"],
            address: "301 Howard St",
            city: "San Francisco",
            state: "CA",
            title: "Modern apartment in the heart of San Francisco",
            rating: 4.5,
            features: [.selfCheckIn, .superHost],
            amenities: [.pool, .kitchen, .wifi, .laundry, .tv, .alarmSystem, .office, .balcony],
            type: .apartment
        ),
        RentPlaceModel(
            id: NSUUID().uuidString,
            ownerUid: "2",
            ownerName: "Clark Manta",
            ownerImageUrl: "woman1",
            numberOfBedrooms: 3,
            numberOfBathrooms: 2,
            numberOfGuests: 4,
            numberOfBeds: 3,
            pricePerNight: 300,
            latitude: 52.283333,
            longitude: 8.050000,
            imageUrls: ["b1", "b2", "b3"],
            address: "11.fahr",
            city: "Osnabruck",
            state: "Germany",
            title: "Modern apartment in the heart of San Francisco",
            rating: 4.8,
            features: [.selfCheckIn, .superHost],
            amenities: [.pool, .kitchen, .wifi, .laundry, .tv, .alarmSystem, .office, .balcony],
            type: .apartment
        ),
        RentPlaceModel(
            id: NSUUID().uuidString,
            ownerUid: "3",
            ownerName: "Emre Şimşek",
            ownerImageUrl: "emre",
            numberOfBedrooms: 4,
            numberOfBathrooms: 3,
            numberOfGuests: 5,
            numberOfBeds: 4,
            pricePerNight: 400,
            latitude: 40.783333,
            longitude: 30.400000,
            imageUrls: ["c1", "c2", "c3"],
            address: "1560. sokak",
            city: "Sakarya",
            state: "Turkey",
            title: "The beautiful house in the center of Sakarya",
            rating: 4.9,
            features: [.selfCheckIn, .superHost],
            amenities: [.pool, .kitchen, .wifi, .laundry, .tv, .alarmSystem, .office, .balcony],
            type: .apartment
        ),
    ]
}
