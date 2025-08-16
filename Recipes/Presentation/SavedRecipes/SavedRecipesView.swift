//
//  SavedRecipesView.swift
//  Recipes
//
//  Created by Dylan on 16/8/25.
//

import SwiftUI
import SwiftData
import SwiftUINavigationTransitions

struct SavedRecipesView: View {
    @State private var viewModel: SavedRecipesViewModel
    init(modelContext: ModelContext) {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor.accent,
        ]
        _viewModel = State(
            initialValue: SavedRecipesViewModel(modelContext: modelContext)
        )
    }
    var body: some View {
        ZStack {
            if viewModel.savedRecipes.isEmpty {
                ContentUnavailableView(
                    "Empty saved recipes",
                    systemImage: "fork.knife",
                    description: Text("Save a new recipe and it will show up here.")
                )
            } else {
                List {
                    ForEach(viewModel.savedRecipes) { savedRecipe in
                        let recipe = Recipe(id: savedRecipe.id, name: savedRecipe.name ?? "Unknown", image: savedRecipe.image)
                        RecipeView(recipe: recipe)
                            .background {
                                NavigationLink(value: savedRecipe) {
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let savedRecipe = viewModel.savedRecipes[index]
                            viewModel.removeSavedRecipe(savedRecipe)
                        }
                    })
                    .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 8.0))
                    .listRowBackground(Color.clear)
                }
                .contentMargins(12.0)
                .listRowSpacing(12.0)
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Saved Recipes")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: SavedRecipe.self) { savedRecipe in
            SavedRecipeDetailsView(savedRecipe: savedRecipe)
        }
        .navigationTransition(
            .slide(axis: .horizontal).combined(with: .fade(.in)),
            interactivity: .pan
        )
        .onAppear {
            viewModel.getSavedRecipes()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: SavedRecipe.self, configurations: config)
        return NavigationStack {
            SavedRecipesView(
                modelContext: modelContainer.mainContext
            )
        }
    } catch {
        fatalError("Failed to create ModelContainer for Saved Recipe.")
    }
}
