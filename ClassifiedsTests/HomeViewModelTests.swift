//
//  HomeViewModelTests.swift
//  ClassifiedsTests
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import XCTest
import Combine
@testable import Classifieds

final class HomeViewModelTests: XCTestCase {
    
    private var mockListingsService: MockListingsService!
    
    // sut
    private var viewModel: HomeViewModel!
    
    private var cancellabels: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        mockListingsService = MockListingsService()
        viewModel = HomeViewModel(listingsService: mockListingsService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockListingsService = nil
    }
    
    func testInitialLoadingState() {
        XCTAssertEqual(viewModel.loadingState, .idle)
    }
    
    func testFetchDataSetsLoadingState() {
        // Act
        viewModel.fetchData()
        
        // Assert
        XCTAssertEqual(viewModel.loadingState, .loading)
    }
    
    func testFetchDataFailure() {
        // Arrange
        let error = FakeError()
        mockListingsService.setError(error)
        
        let exp = expectation(description: "")
        exp.assertForOverFulfill = false
        var value: HomeViewModel.LoadingState?
        
        viewModel.$loadingState
            .dropFirst(2) // ignore idle and loading states
            .handleEvents(
                receiveCompletion: { _ in
                    exp.fulfill()
                }
            )
            .sink {
                exp.fulfill()
                value = $0
            }
            .store(in: &cancellabels)
        
        // Act
        viewModel.fetchData()
        
        wait(for: [exp], timeout: 1.0)
        
        // Assert
        XCTAssertEqual(value, .failed(error))
    }
    
    func testFetchDataSucceed() {
        // Arrange
        let listings = [Listing](repeating: .sample, count: 3)
        mockListingsService.setListings(listings)
        
        let exp = expectation(description: "")
        exp.assertForOverFulfill = false
        var value: HomeViewModel.LoadingState?
        
        viewModel.$loadingState
            .dropFirst(2) // ignore idle and loading states
            .handleEvents(
                receiveCompletion: { _ in
                    exp.fulfill()
                }
            )
            .sink {
                exp.fulfill()
                value = $0
            }
            .store(in: &cancellabels)
        
        // Act
        viewModel.fetchData()
        
        wait(for: [exp], timeout: 1.0)
        
        // Assert
        XCTAssertEqual(value, .loaded(listings))
    }
    
}
