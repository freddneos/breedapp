//
//  BreedAppTests.swift
//  BreedAppTests
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import XCTest
@testable import BreedApp


class DogBreedServiceTests: XCTestCase {
    
    var sut: DogBreedService! // sut stands for System Under Test
    
    override func setUp() {
        super.setUp()
        sut = DogBreedService()
    }
    
    override func tearDown() {
        sut = nil 
        super.tearDown()
    }
    
    func testGetBreedsByName_Success() async throws {
        // Given a search term
        let searchTerm = "Labrador"
        
        // When fetching breeds by name
        do {
            let breeds = try await sut.getBreedsByName(searchTerm: searchTerm)
            
            // Then breeds data should be fetched successfully
            XCTAssertFalse(breeds.isEmpty, "Breeds data should be fetched for the search term \(searchTerm)")
        } catch {
            XCTFail("Expected breeds data to be fetched successfully, but received an error: \(error)")
        }
    }
    
    func testGetBreedsByPage_Success() async throws {
        // Given page parameters
        let page = 1
        let limit = 10
        
        // When fetching breeds by page
        do {
            let breeds = try await sut.getBreedsByPage(page: page, pageLimit: limit)
            
            // Then breeds data should be fetched successfully
            XCTAssertFalse(breeds.isEmpty, "Breeds data should be fetched for page \(page) with limit \(limit)")
        } catch {
            XCTFail("Expected breeds data to be fetched successfully, but received an error: \(error)")
        }
    }
    
    func testGetBreedById_Failure() async throws {
        // Given an invalid breed ID
        let invalidId = -1
        
        // When fetching breed by invalid ID
        do {
            let _ = try await sut.getBreedById(id: invalidId)
            XCTFail("Expected fetching by invalid ID to fail, but it succeeded")
        } catch {
            // Then an error should be thrown
            XCTAssertTrue(error is DogBreedService.APIError, "Expected APIError but got \(type(of: error))")
        }
    }
}
