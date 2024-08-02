//
//  DestinationSearchView.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 27.07.2024.
//

import SwiftUI

struct DestinationSearchView: View {
    @Binding var show: Bool
    @State private var selectedDestination: DestinationSearchOption = .location
    @State private var selectedAdults: Int = 0
    @ObservedObject var exploreVM: ExploreViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                NavigateBackButton(show: $show)
                Spacer()
                ClearButton(exploreVM: exploreVM)
            }

            WhereView(
                destination: $exploreVM.destination,
                selectedDestination: $selectedDestination,
                exploreVM: exploreVM,
                show: $show
            )

            WhenView(selectedDestination: $selectedDestination)

            WhoView(selectedDestination: $selectedDestination, selectedAdults: $selectedAdults)
            Spacer()
        }
        .padding()
    }

}

#Preview {
    DestinationSearchView(show: .constant(false), exploreVM: ExploreViewModel())
}

struct WhereView: View {
    @Binding var destination: String
    @Binding var selectedDestination: DestinationSearchOption
    @ObservedObject var exploreVM: ExploreViewModel
    @Binding var show: Bool
    var body: some View {

        if selectedDestination == .location {
            VStack(alignment: .leading) {
                Text("Where to?")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.small)

                    TextField("Search destinations", text: $destination)
                        .font(.subheadline)
                        .onSubmit {
                            exploreVM.filterRentedPlaces()
                            show.toggle()
                        }

                }
                .frame(height: 44)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .frame(height: selectedDestination == .location ? 160 : 64)
            .background(.cWhite)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 10)
        }
        else {
            SearchItemView(title: "Where", description: "Add destination")
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedDestination = .location
                    }
                }
        }

    }
}

private struct SearchItemView: View {
    let title: String
    let description: String
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.gray)
                Spacer()
                Text(description)
            }
            .fontWeight(.semibold)
            .font(.subheadline)
        }
        .padding()
        .background(.cWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 10)
    }
}

enum DestinationSearchOption {
    case location
    case dates
    case guests
}

private struct NavigateBackButton: View {
    @Binding var show: Bool
    var body: some View {
        Button(
            action: {
                withAnimation(.snappy) {
                    show.toggle()
                }
            },
            label: {
                Image(systemName: "xmark.circle")
                    .imageScale(.large)
                    .foregroundStyle(.cBlack)
            }
        )
    }
}

private struct WhenView: View {
    @Binding var selectedDestination: DestinationSearchOption
    @State var fromDate = Date()
    @State var toDate = Date()
    var body: some View {
        VStack {
            if selectedDestination == .dates {
                VStack(alignment: .leading, spacing: 16) {
                    Text("When's your trip?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    VStack(spacing: 8) {
                        DatePicker("From :", selection: $fromDate, displayedComponents: .date)
                        DatePicker("To :", selection: $toDate, displayedComponents: .date)
                    }
                    .foregroundStyle(.gray)

                }
                .padding()
                .frame(height: selectedDestination == .dates ? 160 : 64)
                .background(.cWhite)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 10)

            }
            else {
                SearchItemView(title: "When", description: "Add dates")
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedDestination = .dates
                        }
                    }
            }
        }
    }
}

struct WhoView: View {
    @Binding var selectedDestination: DestinationSearchOption
    @Binding var selectedAdults: Int
    var body: some View {
        VStack {
            if selectedDestination == .guests {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Who's coming?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack {
                        Stepper {
                            Text("\(selectedAdults) Adults")
                        } onIncrement: {
                            selectedAdults = selectedAdults + 1
                        } onDecrement: {
                            if selectedAdults == 0 {
                                return
                            }
                            else {
                                selectedAdults = selectedAdults - 1
                            }

                        }
                    }
                }
                .padding()
                .frame(height: selectedDestination == .guests ? 160 : 64)
                .background(.cWhite)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 10)
            }
            else {
                SearchItemView(title: "Who", description: "Add guests")
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedDestination = .guests
                        }
                    }
            }

        }
    }
}

private struct ClearButton: View {
    @ObservedObject var exploreVM: ExploreViewModel
    var body: some View {
        VStack {
            if !exploreVM.destination.isEmpty {
                Button("Clear") {
                    exploreVM.destination = ""
                    exploreVM.removeFilterFromRentedPlaces()
                }
            }
        }
    }
}
