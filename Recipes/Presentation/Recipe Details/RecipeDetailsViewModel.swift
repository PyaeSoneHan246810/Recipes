//
//  RecipeDetailsViewModel.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation
import Observation
import SwiftData

@Observable
class RecipeDetailsViewModel {
    private(set) var recipeDetailsDataState: DataState<RecipeDetails> = .idle
    private(set) var savedRecipes: [SavedRecipe] = []
    
    private let recipeId: String
    private let getRecipeDetailsUsecase: GetRecipeDetailsUsecase
    private let modelContext: ModelContext
    
    init(recipeId: String, recipeRepository: RecipeRepository, modelContext: ModelContext) {
        self.recipeId = recipeId
        getRecipeDetailsUsecase = GetRecipeDetailsUsecase(repository: recipeRepository)
        self.modelContext = modelContext
    }
    
    var ingredients: [Ingredient] {
        if case .success(let recipeDetails) = recipeDetailsDataState {
            var ingredients: [Ingredient] = []
            let mirror = Mirror(reflecting: recipeDetails)
            for (label, value) in mirror.children {
                if let label, label.starts(with: "ingredient"), let ingredientName = value as? String, !ingredientName.isEmpty {
                    let ingredientNo = label.dropFirst("ingredient".count)
                    if let measure = mirror.descendant("measure\(ingredientNo)") as? String {
                        let ingredient = Ingredient(name: ingredientName, measure: measure)
                        ingredients.append(ingredient)
                    }
                }
            }
            return ingredients
        } else {
            return []
        }
    }
    
    func getRecipeDetails() async {
        recipeDetailsDataState = .loading
        let result = await getRecipeDetailsUsecase.execute(id: recipeId)
        switch result {
        case .success(let recipeDetails):
            recipeDetailsDataState = .success(data: recipeDetails)
        case .failure(let error):
            recipeDetailsDataState = .failure(error: error)
        }
    }
    
    func getSavedRecipes() {
        let fetchDescriptor: FetchDescriptor<SavedRecipe> = .init(sortBy: [SortDescriptor(\.name)])
        do {
            savedRecipes = try modelContext.fetch(fetchDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var isRecipeSaved: Bool {
        savedRecipes.contains { $0.id == recipeId }
    }
    
    func saveRecipe() {
        if case .success(let recipeDetails) = recipeDetailsDataState {
            let savedRecipe = SavedRecipe(from: recipeDetails)
            modelContext.insert(savedRecipe)
            getSavedRecipes()
        }
    }
    
    func removeSavedRecipe() {
        let savedRecipe = savedRecipes.first { $0.id == recipeId }
        guard let savedRecipe else { return }
        modelContext.delete(savedRecipe)
        getSavedRecipes()
    }
}
