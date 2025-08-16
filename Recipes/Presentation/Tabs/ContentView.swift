//
//  ContentView.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let remoteCategoryRepository = RemoteCategoryRepository(apiService: MealsDbApiService())
    let remoteRecipeRepository = RemoteRecipeRepository(apiService: MealsDbApiService())
    let modelContext: ModelContext
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                NavigationStack {
                    HomeView(
                        categoryRepository: remoteCategoryRepository,
                        recipeRepository: remoteRecipeRepository,
                        modelContext: modelContext
                    )
                }
            }
            Tab("Search", systemImage: "magnifyingglass") {
                NavigationStack {
                    SearchView(
                        recipeRepository: remoteRecipeRepository,
                        modelContext: modelContext
                    )
                }
            }
            Tab("Saved", systemImage: "bookmark") {
                NavigationStack {
                    SavedRecipesView(
                        modelContext: modelContext
                    )
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: SavedRecipe.self, configurations: config)
        return ContentView(
            modelContext: modelContainer.mainContext
        )
    } catch {
        fatalError("Failed to create ModelContainer for Saved Recipe.")
    }
}
