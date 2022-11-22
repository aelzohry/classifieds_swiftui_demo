//
//  ListingsResponse.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import Foundation

/*
 {
    "results": [], // array of Listing
    "pagination": {
        "key": null
    }
 }
 */
struct ListingsResponse: Decodable {
    let results: [Listing]
}
