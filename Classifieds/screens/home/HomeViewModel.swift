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
        fetchData()
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
