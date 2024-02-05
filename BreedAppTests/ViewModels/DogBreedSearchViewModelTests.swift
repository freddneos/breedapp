//
//  DogBreedSearchViewModelTests.swift
//  BreedAppTests
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import XCTest
import Combine
@testable import BreedApp

class DogBreedSearchViewModelTests: XCTestCase {
    var viewModel: DogBreedSearchViewModel!
    var mockService: MockDogBreedService!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockService = MockDogBreedService()
        viewModel = DogBreedSearchViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testSearchForBreedSuccess() {
        let expectedBreeds = [DogBreed(id: 1, name: "Labrador", designation: "Companion", group: "Sporting", lifeSpan: "10-12 years", temperament: "Friendly", origin: "Canada", weight: Weight(weightInMetric: "29-36"), height: Height(heightInMetric: "55-62"), referenceImageId: "labrador")]
        mockService.breeds = expectedBreeds
        
        let expectation = XCTestExpectation(description: "Search breeds success")
        
        viewModel.$searchResults
            .dropFirst()
            .sink { breeds in
                XCTAssertEqual(breeds, expectedBreeds)
                XCTAssertFalse(self.viewModel.showEmptyState)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.searchText = "Labrador"
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchForBreedEmptyInput() {
        viewModel.searchText = ""
        
        XCTAssertTrue(viewModel.searchResults.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showEmptyState)
    }
    
    func testSearchForBreedFailure() {
        mockService.error = NSError(domain: "com.BreedAppTests", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock fetch error"])
        
        let expectation = XCTestExpectation(description: "Search breeds failure")
        
        viewModel.$searchResults
            .dropFirst()
            .sink { _ in
                XCTAssertTrue(self.viewModel.searchResults.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.searchText = "Nonexistent"
        
        wait(for: [expectation], timeout: 2)
    }
}
