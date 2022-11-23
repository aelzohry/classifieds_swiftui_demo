//
//  MockListingsService.swift
//  ClassifiedsTests
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import Foundation
import Combine
@testable import Classifieds

struct FakeError: Error { }

class MockListingsService: ListingsService {
    
    var result: AnyPublisher<[Listing], Error>!
    
    init() { setListings([]) }
    
    func setError(_ error: Error) {
        result = Fail(error: error)
            .eraseToAnyPublisher()
    }
    
    func setListings(_ list: [Listing]) {
        result = Just(list)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchListings() -> AnyPublisher<[Listing], Error> {
        result
    }
    
}
