//
//  ListingDetailsViewModel.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import Foundation

struct ListingDetailsViewModel {
    
    let listing: Listing
    
    var name: String { listing.name }
    
    var price: String { listing.price }
    
    var date: String {
        listing.createdAt.formatted(
            .relative(presentation: .named)
        )
    }
    
    var imageUrls: [URL] {
        listing.imageUrls.compactMap(URL.init)
    }
    
}
