//
//  RecipeDetailsViewModel.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation
import Observation

@Observable
class RecipeDetailsViewModel {
    private(set) var recipeDetailsDataState: DataState<RecipeDetails> = .idle
    
    private let recipeId: String
    private let getRecipeDetailsUsecase: GetRecipeDetailsUsecase
    
    init(recipeId: String, recipeRepository: RecipeRepository) {
        self.recipeId = recipeId
        getRecipeDetailsUsecase = GetRecipeDetailsUsecase(repository: recipeRepository)
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
            recipeDetailsDataState = .failure(error: EquatableError(error: error))
        }
    }
}
