//
//  ListingsService.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import Foundation
import Combine

protocol ListingsService {
    func fetchListings() -> AnyPublisher<[Listing], Error>
}
