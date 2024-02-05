//
//  DogBreedSearch.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import Combine
import Foundation

class DogBreedSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [DogBreed] = []
    @Published var isLoading = false
    @Published var showEmptyState = false
    
    private let service: DogBreedServiceProtocol
    private var searchCancellable: AnyCancellable?
    private let debounceDelay = 0.5 // Debounce delay in seconds
    
    init(service: DogBreedServiceProtocol = DogBreedService()) {
        self.service = service
        setupSearchSubscription()
    }
    
    private func setupSearchSubscription() {
        searchCancellable = $searchText
            .removeDuplicates()
            .debounce(for: .seconds(debounceDelay), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchForBreed(with: searchText)
            }
    }
    
    func searchForBreed(with searchText: String) {
        guard !searchText.isEmpty else {
            searchResults = []
            showEmptyState = false
            return
        }
        
        isLoading = true
        showEmptyState = false
        Task {
            do {
                let results = try await service.getBreedsByName(searchTerm: searchText)
                DispatchQueue.main.async {
                    self.searchResults = results
                    self.isLoading = false
                    self.showEmptyState = results.isEmpty
                }
            } catch {
                DispatchQueue.main.async {
                    self.searchResults = []
                    self.isLoading = false
                    self.showEmptyState = true
                }
            }
        }
    }
}


