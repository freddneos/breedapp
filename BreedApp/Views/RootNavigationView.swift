//
//  TabNavigationView.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import SwiftUI

struct RootNavigationView: View {
    var body: some View {
        TabView {
            DogBreedListView()
            .tabItem {
                Label("Breeds", systemImage: "list.dash")
            }
            DogBreedSearchView()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    RootNavigationView()
}

