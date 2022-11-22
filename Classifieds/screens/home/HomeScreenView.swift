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
                    List(viewModel.listings) { listing in
                        ListingView(listing: listing)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Listings")
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
