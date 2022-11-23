//
//  ListingView.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import SwiftUI

struct ListingView: View {
    
    private let listingViewModel: ListingViewModel
    
    init(listing: Listing) {
        listingViewModel = ListingViewModel(listing: listing)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(listingViewModel.date)
                .font(.caption)
                
                Text(listingViewModel.name)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Text(listingViewModel.price)
                    .fontWeight(.semibold)
            }
            .padding()
            
            Spacer()
            
            if let thumbnailUrl = listingViewModel.thumbnailUrl {
                CachedAsyncImage(
                    url: thumbnailUrl,
                    error: { _ in
                        Image(systemName: "questionmark.diamond.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding()
                    },
                    image: { uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    }
                )
                .frame(width: 120, height: 120)
            }
        }
        .background(
            Color.cyan
                .shadow(.drop(radius: 5, x: 2, y: 2))
        )
    }
    
}

// MARK: - Previews

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(listing: .sample)
            .previewLayout(.sizeThatFits)
    }
}
