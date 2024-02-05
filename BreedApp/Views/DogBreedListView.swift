import SwiftUI

struct DogBreedListView: View {
    @StateObject private var viewModel = DogBreedListViewModel()
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.dogBreeds.isEmpty {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    if viewModel.isGridViewActive {
                        ScrollView {
                            LazyVGrid(columns: gridLayout, spacing: 20) {
                                breedViews
                                loadingIndicator
                            }
                            .padding()
                        }
                    } else {
                        List {
                            breedViews
                            loadingIndicator
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
                if viewModel.dogBreeds.isEmpty {
                    viewModel.fetchDogBreeds()
                }
            }
        }
    }
    
    private var breedViews: some View {
        ForEach(viewModel.dogBreeds) { breed in
            DogBreedView(breed: breed, isGridView: viewModel.isGridViewActive)
        }
    }
    
    private var loadingIndicator: some View {
        Group {
            if viewModel.canLoadMorePages {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .onAppear(perform: viewModel.fetchDogBreeds)
            }
        }
    }
}


struct DogBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedListView()
    }
}
