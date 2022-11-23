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
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                    
                case .loaded(let listing):
                    if listing.isEmpty {
                        noDataView
                    } else {
                        listingsListView(listing)
                    }
                    
                case .failed(let error):
                    errorView(error)
                    
                case .idle:
                    EmptyView()
                }
            }
            .navigationTitle("Listings")
            .sheet(item: $viewModel.selectedListing) { listing in
                ListingDetailsScreenView(listing: listing)
            }
        }
    }
    
    private func listingsListView(_ listings: [Listing]) -> some View {
        List(listings) { listing in
            ListingView(listing: listing)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .onTapGesture {
                    viewModel.selectedListing = listing
                }
        }
        .listStyle(.plain)
    }
    
    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 10) {
            Text("Error loading listing data")
            
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
                .font(.callout)
                .foregroundColor(.gray)
            
            Button("RETRY") {
                viewModel.fetchData()
            }
        }
        .padding()
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
    
    private var noDataView: some View {
        Text("No listing data found")
            .foregroundColor(.gray)
    }
    
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
