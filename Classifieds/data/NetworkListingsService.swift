//
//  NetworkListingsService.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import Foundation
import Combine

class NetworkListingsService: ListingsService {
    
    func fetchListings() -> AnyPublisher<[Listing], Error> {
        let url = URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer")!
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ListingsResponse.self, decoder: jsonDecoder)
            .map(\.results)
            .eraseToAnyPublisher()
    }
    
}
