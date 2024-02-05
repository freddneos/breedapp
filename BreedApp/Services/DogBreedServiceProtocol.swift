//
//  DogBreedServiceProtocol.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import Foundation

protocol DogBreedServiceProtocol {
    func getBreedsByName(searchTerm: String) async throws -> [DogBreed]
    func getBreedsByPage(page: Int, pageLimit: Int) async throws -> [DogBreed]
    func getBreedById(id: Int) async throws -> DogBreed
}
