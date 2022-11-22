//
//  HomeViewModel.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var isLoading: Bool = false
    
    @Published
    private(set) var listings: [Listing] = []
    
    @Published
    var selectedListing: Listing?
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    
    init() {
        fetchData()
    }
    
    // MARK: - Fetching Data
    
    func fetchData() {
        let url = URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer")!
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            // handle loading state
            .map { $0.data }
            .decode(type: ListingsResponse.self, decoder: jsonDecoder)
            // only care about listings array
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveSubscription: { [unowned self] _ in
                    isLoading = true
                },
                receiveCompletion: { [unowned self] _ in
                    isLoading = false
                },
                receiveCancel: { [unowned self] in
                    isLoading = false
                }
            )
            .sink(receiveCompletion: {
                print("Completion: \($0)")
            }, receiveValue: { listings in
                self.listings = listings
                print("Received listings: \(listings.count)")
            })
            .store(in: &cancellables)
    }
    
}
