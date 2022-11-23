//
//  HomeViewModel.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded([Listing])
        case failed(Error)
    }
    
    
    // MARK: - Properties
    
    @Published
    private(set) var loadingState: LoadingState = .idle
    
    @Published
    var selectedListing: Listing?
        
    
    // MARK: - Lifecycle
    
    init() {
        fetchData()
    }
    
    
    // MARK: - Fetching Data
    
    func fetchData() {
        loadingState = .loading
        
        let url = URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer")!
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            // handle loading state
            .map(\.data)
            .decode(type: ListingsResponse.self, decoder: jsonDecoder)
            // only care about listings array
            .map(\.results)
            .map(LoadingState.loaded)
            .catch { error in
                Just(.failed(error))
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$loadingState)
    }
    
}
