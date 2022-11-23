//
//  ListingDetailsScreenView.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import SwiftUI

struct ListingDetailsScreenView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let viewModel: ListingDetailsViewModel
    
    init(listing: Listing) {
        viewModel = ListingDetailsViewModel(listing: listing)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                imagesSlider
                
                Text(viewModel.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                HStack {
                    Text(viewModel.date)
                    
                    Spacer()
                    
                    Text(viewModel.price)
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color(white: 0.8))
                
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
                    ForEach(viewModel.imageUrls, id: \.self) { imageUrl in
                        ImageView(imageUrl: imageUrl, size: proxy.size)
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
    }
    
    private struct ImageView: View {
        let imageUrl: URL
        let size: CGSize
        
        var body: some View {
            CachedAsyncImage(
                url: imageUrl,
                error: { _ in
                    Image(systemName: "questionmark.diamond.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding()
                },
                image: { uiImage in
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                }
            )
            .frame(width: size.width, height: size.height)
        }
    }
    
}

struct ListingDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailsScreenView(listing: .sample)
    }
}
