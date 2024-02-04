//
//  DogBreedListView.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import Foundation
import SwiftUI

struct DogBreedListView: View {
    @StateObject private var viewModel = DogBreedListViewModel()
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    if viewModel.isGridViewActive {
                        ScrollView {
                            LazyVGrid(columns: gridLayout, spacing: 20) {
                                ForEach(viewModel.dogBreeds) { breed in
                                    DogBreedView(breed: breed,isGridView: viewModel.isGridViewActive)
                                }
                            }
                            .padding()
                        }
                    } else {
                        List(viewModel.dogBreeds) { breed in
                            DogBreedView(breed: breed,isGridView: viewModel.isGridViewActive)
                        }
                    }
                   
                }
            }
            .navigationTitle("Dog Breeds")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleViewStyle()
                    }) {
                        Image(systemName: viewModel.isGridViewActive ? "list.bullet" : "square.grid.2x2")
                    }
                    Button(action: {
                        viewModel.orderBreedsAlphabetically()
                    }) {
                        Image(systemName: viewModel.isSorted ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle")

                    }
                }
            }
            .onAppear {
                viewModel.fetchDogBreeds()
            }
        }
    }


#Preview {
    TabNavigationView()
}
