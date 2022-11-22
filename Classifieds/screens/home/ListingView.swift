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
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(listing.createdAt)
                    .font(.caption)
                
                Text(listing.name)
                    .fontWeight(.heavy)
                
                Text(listing.price)
                    .fontWeight(.semibold)
            }
            .padding()
            
            Spacer()
            
            if let thumbnailUrl = listing.thumbnailUrl {
                AsyncImage(url: thumbnailUrl) {
                    phase in
                    if let image = phase.image {
                        // image loaded, present it
                        image
                            .resizable()
                            .scaledToFill()
                    } else if let _ = phase.error {
                        // failed to load the image
                        Image(systemName: "questionmark.diamond.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        // image is loading
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
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
