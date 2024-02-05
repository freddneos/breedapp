//
//  DogBreedDetailViewModelTests.swift
//  BreedAppTests
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import XCTest
@testable import BreedApp

class DogBreedDetailViewModelTests: XCTestCase {
    var viewModel: DogBreedDetailViewModel!
    var mockService: MockDogBreedService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockDogBreedService()
        viewModel = DogBreedDetailViewModel(service: mockService, breedId: 1)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        try super.tearDownWithError()
    }
    
    func testFetchBreedDetailSuccess() {
        let expectedBreed = DogBreed(id: 1, name: "Test Breed", designation: "Some Designation", group: "Some Group", lifeSpan: "10-12 years", temperament: "Friendly", origin: "Testland", weight: Weight(weightInMetric: "20-30"), height: Height(heightInMetric: "45-55"), referenceImageId: "someImageId")
        mockService.breeds = [expectedBreed]
        
        let expectation = XCTestExpectation(description: "Fetch breed detail")
        
        viewModel.fetchBreedDetail()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.dogBreed, expectedBreed)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchBreedDetailFailure() {
        mockService.error = NSError(domain: "com.BreedAppTests", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock fetch error"])
        
        let expectation = XCTestExpectation(description: "Handle error in fetch breed detail")
        
        viewModel.fetchBreedDetail()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewModel.dogBreed)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
