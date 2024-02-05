//
//  DogBreedDetailView.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 05/02/2024.
//
import SwiftUI

struct DogBreedDetailView: View {
    @StateObject var viewModel: DogBreedDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let breed = viewModel.dogBreed {
                    AsyncImage(url: breed.imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    
                   
                    VStack(alignment: .leading, spacing: 8) {
                        Text(breed.name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Lifespan: \(breed.lifeSpan)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    
                    if let temperament = breed.temperament {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Temperament")
                                .font(.headline)
                            
                            Text(temperament)
                        }
                    }
                    
                    Divider()
                    
                    if let origin = breed.origin {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Origin")
                                .font(.headline)
                            
                            Text(origin)
                        }
                    }
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.dogBreed?.name ?? "Breed Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchBreedDetail()
        }
    }
}
