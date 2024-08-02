//
//  ListingItemModel.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import Foundation

struct ListingItemModel: Identifiable {
    let id: UUID = UUID()
    let location: String
    let distance: String
    let date: String
    let price: String
    let rate: String
    let imageSource: [ListingItemImages]
    let features: [ItemFeatures]
    let bedroomNumber: Int
    let itemOffers: [ItemOffersOptions]
}

extension ListingItemModel {

    static let item: ListingItemModel =
        ListingItemModel(
            location: "Miami, Florida",
            distance: "12 mil away",
            date: "Nov 3-10",
            price: "$567",
            rate: "4.8",
            imageSource: [ListingItemImages.a1, ListingItemImages.a2, ListingItemImages.a3],
            features: [ItemFeatures.item1, ItemFeatures.item2],
            bedroomNumber: 6,
            itemOffers: [
                ItemOffersOptions.wifi,
                ItemOffersOptions.alarmSystem,
                ItemOffersOptions.balcony,
                ItemOffersOptions.launchdry,
                ItemOffersOptions.tv,

            ]

        )

}

struct ItemFeatures: Identifiable {
    let id: UUID = UUID()
    let iconName: String
    let title: String
    let description: String
}

extension ItemFeatures {
    static let item1 = ItemFeatures(
        iconName: "medal",
        title: "Superhost",
        description:
            "Superhosts are ecperience, highly rated hosts who are commited to providing great stars for guests"
    )

    static let item2 = ItemFeatures(
        iconName: "door.left.hand.open",
        title: "Self check-in",
        description: "Check yourself"
    )
}

struct ItemOffers {

    init(iconName: String, title: String) {
        self.iconName = iconName
        self.title = title
    }

    let id: UUID = UUID()
    let iconName: String
    let title: String
}

enum ItemOffersOptions {
    case wifi
    case tv
    case alarmSystem
    case balcony
    case launchdry

    var model: ItemOffers {
        switch self {
            case .wifi:
                return ItemOffers(iconName: "wifi", title: "WIFI")
            case .tv:
                return ItemOffers(iconName: "tv", title: "TV")
            case .alarmSystem:
                return ItemOffers(iconName: "checkmark.shield", title: "Alarm System")
            case .balcony:
                return ItemOffers(iconName: "sun.max", title: "Balcony")
            case .launchdry:
                return ItemOffers(iconName: "dryer", title: "Launchdry")

        }
    }
}
