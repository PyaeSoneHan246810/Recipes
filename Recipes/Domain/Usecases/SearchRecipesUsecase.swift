//
//  SearchRecipesUsecase.swift
//  Recipes
//
//  Created by Dylan on 5/7/25.
//

import Foundation

class SearchRecipesUsecase: RecipeRepositoryUsecase {
    var repository: RecipeRepository
    
    init(repository: RecipeRepository) {
        self.repository = repository
    }
    
    func execute(searchText: String) async -> Result<[RecipeDetails], Error> {
        return await repository.searchRecipes(with: searchText)
    }
}
