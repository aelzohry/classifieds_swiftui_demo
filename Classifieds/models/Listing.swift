//
//  Listing.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import Foundation

/*
 {
     "created_at": "2019-02-24 04:04:17.566515",
     "price": "AED 5",
     "name": "Notebook",
     "uid": "4878bf592579410fba52941d00b62f94",
     "image_ids": [
        "9355183956e3445e89735d877b798689"
     ],
     "image_urls": [
        "..."
     ],
     "image_urls_thumbnails": [
        "..."
     ]
     },
 */
struct Listing: Decodable {
    let uid: String
    let name: String
    let price: String
    let createdAt: String
    let imageUrls: [String]
    let imageUrlsThumbnails: [String]
}

extension Listing: Identifiable {
    var id: String { uid }
}
