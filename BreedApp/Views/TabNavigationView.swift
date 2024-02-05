//
//  TabNavigationView.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import SwiftUI

struct TabNavigationView: View {
    var body: some View {
        TabView {
            DogBreedListView()
            .tabItem {
                Label("Breeds", systemImage: "list.dash")
            }
            NavigationView {
               //DogBreedSearchView() // Implement this view similar to DogBreedsView but with search functionality
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    TabNavigationView()
}

