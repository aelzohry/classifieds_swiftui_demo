//
//  NetworkListingsService.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import Foundation
import Combine

struct NetworkListingsService: ListingsService {
    
    let httpClient: Requestable
    
    init(httpClient: Requestable = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchListings() -> AnyPublisher<[Listing], Error> {
        let url = URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer")!
        let request = URLRequest(url: url)
        
        return httpClient
            .make(request, type: ListingsResponse.self)
            .map(\.results)
            .eraseToAnyPublisher()
    }
    
}
