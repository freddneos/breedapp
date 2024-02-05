//
//  DogBreedSearchView.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import SwiftUI

struct DogBreedSearchView: View {
    @StateObject private var viewModel = DogBreedSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter breed name", text: $viewModel.searchText)
                    .padding(EdgeInsets(top: 8, leading: 40, bottom: 8, trailing: 20)) // Add padding to make space for the icon
                    .font(.title2)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        }
                    )
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.showEmptyState {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 100))
                            .foregroundColor(.gray)
                        Text("No Results")
                            .font(.headline)
                    }
                    .transition(.opacity)
                }
                
                List(viewModel.searchResults) { breed in
                    NavigationLink(destination: DogBreedDetailView(viewModel: DogBreedDetailViewModel(breedId: breed.id))) {
                        DogBreedView(breed: breed, isGridView: false)
                    }
                }
            }
            .navigationTitle("Find a Breed")
        }
    }
}

struct DogBreedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedSearchView()
    }
}
