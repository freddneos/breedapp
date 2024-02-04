//
//  DogBreedListViewModel.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import Foundation
import SwiftUI

class DogBreedListViewModel: ObservableObject {
    @Published var dogBreeds: [DogBreed] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isGridViewActive = false
    @Published var isSorted = false
    private var allBreeds: [DogBreed] = []
    
    private let service: DogBreedServiceProtocol
    
    init(service: DogBreedServiceProtocol = DogBreedService()) {
        self.service = service
    }
    
    func fetchDogBreeds() {
        isLoading = true
        Task {
            do {
                let breeds = try await service.getBreedsByPage(page: 1, pageLimit: 50)
                DispatchQueue.main.async {
                    self.dogBreeds = breeds
                    self.allBreeds = breeds
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func toggleViewStyle() {
        isGridViewActive.toggle()
    }
    
    func orderBreedsAlphabetically() {
        if isSorted {
            dogBreeds = allBreeds
            isSorted = false
        } else {
            dogBreeds.sort { $0.name < $1.name }
            isSorted = true
        }
    }

    
    func resetOrder() {
        dogBreeds = allBreeds
    }
}

