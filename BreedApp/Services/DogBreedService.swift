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
    
    
    func addPlusBetweenWords(searchBreedTerm: String) -> String {
        searchBreedTerm.replacingOccurrences(of: " ", with: "+")
    }
    
    func getBreedsByName(searchTerm: String) async throws -> [DogBreed] {
        let searchTerm = addPlusBetweenWords(searchBreedTerm: searchTerm)
        let endpoint = "\(baseUrl)/v1/breeds/search?q=\(searchTerm)"
        return try await getBreeds(endpoint: endpoint)
    }
    
    func getBreedsByPage(page: Int, pageLimit: Int) async throws -> [DogBreed] {
        let endpoint = "\(baseUrl)/v1/breeds?page=\(page)&limit=\(pageLimit)"
        return try await getBreeds(endpoint: endpoint)
    }
    
    func getBreedById(id: Int) async throws -> DogBreed {
        let endpoint = "\(baseUrl)/v1/breeds/\(id)"
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        return try await fetchData(url: url)
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
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
    
    enum APIError: Error {
        case invalidURL, invalidResponse, invalidData, generalError, internetConnectionError
    }
}
