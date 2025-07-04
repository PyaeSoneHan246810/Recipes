//
//  GetRecipeDetailsUsecase.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

class GetRecipeDetailsUsecase: RecipeRepositoryUsecase {
    var repository: RecipeRepository
    
    init(repository: RecipeRepository) {
        self.repository = repository
    }
    
    func execute(id: String) async -> Result<RecipeDetails, Error> {
        return await repository.getRecipeDetails(id: id)
    }
}
