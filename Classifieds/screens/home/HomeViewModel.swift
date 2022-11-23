//
//  HomeViewModel.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded([Listing])
        case failed(Error)
        
        var value: String {
            return String(describing: self)
        }
        
        static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
            lhs.value == rhs.value
        }
    }
    
    // MARK: - Dependencies
    
    private let listingsService: ListingsService
    
    
    // MARK: - Properties
    
    @Published
    private(set) var loadingState: LoadingState = .idle
    
    @Published
    var selectedListing: Listing?
        
    
    // MARK: - Lifecycle
    
    init(listingsService: ListingsService = NetworkListingsService()) {
        self.listingsService = listingsService
    }
    
    
    // MARK: - Fetching Data
    
    func fetchData() {
        loadingState = .loading
        
        listingsService.fetchListings()
            .map(LoadingState.loaded)
            .catch { error in
                Just(.failed(error))
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$loadingState)
    }
    
}
