//
//  ListingView.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import SwiftUI

struct ListingView: View {
    let listing: Listing
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(listing.createdAt)
                    .font(.caption)
                
                Text(listing.name)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Text(listing.price)
                    .fontWeight(.semibold)
            }
            .padding()
            
            Spacer()
            
            if let thumbnailUrl = listing.thumbnailUrl {
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

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(listing: .sample)
            .previewLayout(.sizeThatFits)
    }
}
