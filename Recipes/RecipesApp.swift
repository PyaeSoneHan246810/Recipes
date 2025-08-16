//
//  RecipesApp.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    let modelContainer: ModelContainer
    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: SavedRecipe.self, configurations: config)
        } catch {
            fatalError("Failed to create ModelContainer for Saved Recipe.")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView(
                modelContext: modelContainer.mainContext
            )
        }
    }
}
