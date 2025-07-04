//
//  GetRecipesByCategoryUsecase.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

class GetRecipesByCategoryUsecase: RecipeRepositoryUsecase {
    var repository: RecipeRepository
    
    init(repository: RecipeRepository) {
        self.repository = repository
    }
    
    func execute(categoryName: String) async -> Result<[Recipe], Error> {
        return await repository.getRecipes(by: categoryName)
    }
}
