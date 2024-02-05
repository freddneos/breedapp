//
//  DogBreedService.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//
import Foundation

class DogBreedService: DogBreedServiceProtocol {
   
    
    private let baseUrl = "https://api.thedogapi.com"
    // TODO: remove from here
    private let apiKey = "live_N9ZV7TcPCxKSdrFXMF0LHD6gKL2FWEyCcfTPMHzpQ51utG21myWaXOiPtrUWOVyN"
   
    private let cacheManager = CacheManager.shared
    
    func cacheKeyForPage(_ page: Int) -> String {
        "DogBreedsPage_\(page)"
    }
    
    func cacheKeyForBreedId(_ id: Int) -> String {
        "DogBreed_\(id)"
    }
    
    func cacheKeyForSearchTerm(_ searchTerm: String) -> String {
        "SearchTerm_\(searchTerm)"
    }
    
    func addPlusBetweenWords(searchBreedTerm: String) -> String {
        searchBreedTerm.replacingOccurrences(of: " ", with: "+")
    }
    
    func getBreedsByPage(page: Int, pageLimit: Int) async throws -> [DogBreed] {
        let key = cacheKeyForPage(page)
        if let cachedBreeds: [DogBreed] = cacheManager.getCachedData(forKey: key) {
            return cachedBreeds
        } else {
            let endpoint = "\(baseUrl)/v1/breeds?page=\(page)&limit=\(pageLimit)"
            guard let url = URL(string: endpoint) else {
                throw APIError.invalidURL
            }
            let breeds: [DogBreed] = try await fetchData(url: url)
            cacheManager.cacheData(breeds, forKey: key)
            return breeds
        }
    }
    
    func getBreedsByName(searchTerm: String) async throws -> [DogBreed] {
        let key = cacheKeyForSearchTerm(searchTerm)
        if let cachedBreeds: [DogBreed] = cacheManager.getCachedData(forKey: key) {
            return cachedBreeds
        } else {
            let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
            let endpoint = "\(baseUrl)/v1/breeds/search?q=\(searchTerm)"
            guard let url = URL(string: endpoint) else {
                throw APIError.invalidURL
            }
            let breeds: [DogBreed] = try await fetchData(url: url)
            cacheManager.cacheData(breeds, forKey: key)
            return breeds
        }
    }
    
    func getBreedById(id: Int) async throws -> DogBreed {
        let key = cacheKeyForBreedId(id)
        if let cachedBreed: DogBreed = cacheManager.getCachedData(forKey: key) {
            return cachedBreed
        } else {
            let endpoint = "\(baseUrl)/v1/breeds/\(id)"
            guard let url = URL(string: endpoint) else {
                throw APIError.invalidURL
            }
            let breed: DogBreed = try await fetchData(url: url)
            cacheManager.cacheData(breed, forKey: key)
            return breed
        }
    }
    
    private func getBreeds(endpoint: String) async throws -> [DogBreed] {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        return try await fetchData(url: url)
    }
    
    private func fetchData<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
    
    enum APIError: Error {
        case invalidURL, invalidResponse, invalidData, generalError, internetConnectionError
    }
}
