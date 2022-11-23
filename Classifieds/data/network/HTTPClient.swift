//
//  HTTPClient.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import Foundation
import Combine

protocol Requestable {
    func make<T: Decodable>(_ request: URLRequest, type: T.Type) -> AnyPublisher<T, Error>
}

struct HTTPClient: Requestable {
    
    static var defaultJSONDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss.SSS"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
    
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = HTTPClient.defaultJSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func make<T: Decodable>(_ request: URLRequest, type: T.Type) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: type, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
