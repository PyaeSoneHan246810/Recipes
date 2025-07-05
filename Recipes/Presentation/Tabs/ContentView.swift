//
//  ContentView.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI

struct ContentView: View {
    let remoteCategoryRepository = RemoteCategoryRepository(apiService: MealsDbApiService())
    let remoteRecipeRepository = RemoteRecipeRepository(apiService: MealsDbApiService())
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                NavigationStack {
                    HomeView(
                        categoryRepository: remoteCategoryRepository,
                        recipeRepository: remoteRecipeRepository
                    )
                }
            }
            Tab("Search", systemImage: "magnifyingglass") {
                NavigationStack {
                    SearchView(recipeRepository: remoteRecipeRepository)
                }
            }
            Tab("Saved", systemImage: "bookmark") {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
