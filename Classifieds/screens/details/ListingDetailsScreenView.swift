//
//  ListingDetailsScreenView.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import SwiftUI

struct ListingDetailsScreenView: View {
    @Environment(\.dismiss) private var dismiss
    
    let listing: Listing
    
    var imageUrls: [URL] {
        listing.imageUrls.compactMap(URL.init)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                imagesSlider
                
                Text(listing.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                HStack {
                    Text(listing.createdAt)
                    Spacer()
                    Text(listing.price)
                }
                .padding()
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
            .navigationTitle("Listing Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var imagesSlider: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 10) {
                    ForEach(imageUrls, id: \.self) { imageUrl in
                        ImageView(imageUrl: imageUrl, size: proxy.size)
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250)
    }
    
    private struct ImageView: View {
        let imageUrl: URL
        let size: CGSize
        
        var body: some View {
            AsyncImage(url: imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if let _ = phase.error {
                    Image(systemName: "questionmark.diamond.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ProgressView()
                }
            }
            .frame(width: size.width, height: size.height)
        }
    }
    
}

struct ListingDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailsScreenView(listing: .sample)
    }
}