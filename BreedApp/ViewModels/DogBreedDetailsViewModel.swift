//
//  DogBreedDetailsViewModel.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import Foundation

class DogBreedDetailViewModel: ObservableObject {
    @Published var dogBreed: DogBreed?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: DogBreedServiceProtocol
    private var breedId: Int
    
    init(service: DogBreedServiceProtocol = DogBreedService(), breedId: Int) {
        self.service = service
        self.breedId = breedId
    }
    
    func fetchBreedDetail() {
        isLoading = true
        Task {
            do {
                let breedDetail = try await service.getBreedById(id: breedId)
                DispatchQueue.main.async {
                    self.dogBreed = breedDetail
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
}
