//
//  ExploreView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 26.07.2024.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var exploreVM = ExploreViewModel()
    @EnvironmentObject var globalDatas: GlobalDatas
    @State private var showDestinationSearchView: Bool = false
    var body: some View {
        NavigationStack {
            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView, exploreVM: exploreVM)
            }
            else {
                BodyView(
                    rentedPlaces: $exploreVM.rentedPlaces,
                    showDestinationSearchView: $showDestinationSearchView,
                    destination: $exploreVM.destination
                )
            }
        }
        
    }
}

private struct BodyView: View {
    @Binding var rentedPlaces: [RentPlaceModel]
    @Binding var showDestinationSearchView: Bool
    @Binding var destination: String
    var body: some View {
        VStack(spacing: 20) {
            SearchAndFilterBar(destination: $destination)
                .onTapGesture {
                    withAnimation(.snappy) {
                        showDestinationSearchView.toggle()
                    }
                }
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
        .tabBarPagePadding()
        
//        .padding(.bottom,.dynamicHeight(height: 0.015))
//        .frame(height: .dynamicHeight(height: 0.73))
    }
}

#Preview {
    ExploreView()
}
