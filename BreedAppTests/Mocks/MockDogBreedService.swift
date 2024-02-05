//
//  MockDogBreedService.swift
//  BreedAppTests
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import Foundation
@testable import BreedApp


class MockDogBreedService: DogBreedServiceProtocol {
  
    
    var breeds: [DogBreed] = []
    var error: Error?
    
    func getBreedById(id: Int) async throws -> DogBreed {
        if let error = error {
            throw error
        }
        return breeds.first { $0.id == id }!
    }
    
    func getBreedsByPage(page: Int, pageLimit: Int) async throws -> [DogBreed] {
        if let error = error {
            throw error
        }
        return breeds
    }
    
    func getBreedsByName(searchTerm: String) async throws -> [DogBreed] {
        if let error = error {
            throw error
        }
        return breeds.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    
}
