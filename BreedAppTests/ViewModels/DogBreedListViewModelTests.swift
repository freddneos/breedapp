//
//  DogBreedListViewModelTests.swift
//  BreedAppTests
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import XCTest
@testable import BreedApp

class DogBreedListViewModelTests: XCTestCase {
    var viewModel: DogBreedListViewModel!
    var mockService: MockDogBreedService!
    
    override func setUp() {
        super.setUp()
        mockService = MockDogBreedService()
        viewModel = DogBreedListViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchDogBreedsSuccess() {
        let expectedBreeds = [DogBreed(id: 1, name: "Test Breed", designation: "Some Designation", group: "Some Group", lifeSpan: "10-12", temperament: "Friendly", origin: "Testland", weight: Weight(weightInMetric: "20-30"), height: Height(heightInMetric: "45-55"), referenceImageId: "someImageId")]

        mockService.breeds = expectedBreeds
        
        viewModel.fetchDogBreeds()
        
        // Since fetching is async, use expectation to wait for the result
        let expectation = XCTestExpectation(description: "Fetch breeds")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.dogBreeds, expectedBreeds)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchDogBreedsFailure() {
        mockService.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        
        viewModel.fetchDogBreeds()
        
        let expectation = XCTestExpectation(description: "Fetch breeds failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testToggleViewStyle() {
        XCTAssertFalse(viewModel.isGridViewActive)
        
        viewModel.toggleViewStyle()
        
        XCTAssertTrue(viewModel.isGridViewActive)
    }
    
    func testOrderBreedsAlphabetically() {
        viewModel.dogBreeds = [DogBreed(id: 2, name: "Breed B", designation: "Designation B", group: "Group B", lifeSpan: "", temperament: "", origin: "", weight: Weight(weightInMetric: "25-35"), height: Height(heightInMetric: "50-60"), referenceImageId: "imageIdB"),
                               DogBreed(id: 1, name: "Breed A", designation: "Designation A", group: "Group A", lifeSpan: "", temperament: "", origin: "", weight: Weight(weightInMetric: "15-25"), height: Height(heightInMetric: "40-50"), referenceImageId: "imageIdA")]
         viewModel.orderBreedsAlphabetically()
        
        XCTAssertEqual(viewModel.dogBreeds.first?.name, "Breed A")
        XCTAssertTrue(viewModel.isSorted)
    }
}
