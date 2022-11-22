//
//  HomeScreenView.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if (viewModel.isLoading) {
                    ProgressView()
                } else {
                    listingsList
                }
            }
            .navigationTitle("Listings")
            .sheet(item: $viewModel.selectedListing) { listing in
                ListingDetailsScreenView(listing: listing)
            }
        }
    }
    
    private var listingsList: some View {
        List(viewModel.listings) { listing in
            ListingView(listing: listing)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .onTapGesture {
                    viewModel.selectedListing = listing
                }
        }
        .listStyle(.plain)
    }
    
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
