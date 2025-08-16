//
//  SavedRecipesViewModel.swift
//  Recipes
//
//  Created by Dylan on 16/8/25.
//

import Foundation
import Observation
import SwiftData

@Observable
class SavedRecipesViewModel {
    private let modelContext: ModelContext
    private(set) var savedRecipes: [SavedRecipe] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getSavedRecipes() {
        let fetchDescriptor: FetchDescriptor<SavedRecipe> = .init(sortBy: [SortDescriptor(\.name)])
        do {
            savedRecipes = try modelContext.fetch(fetchDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeSavedRecipe(_ savedRecipe: SavedRecipe) {
        modelContext.delete(savedRecipe)
        getSavedRecipes()
    }
}
