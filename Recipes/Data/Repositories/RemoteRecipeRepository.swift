//
//  RemoteRecipeRepository.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

class RemoteRecipeCategory: RecipeRepository {
    let apiService: ApiService
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    func getRecipes(by categoryName: String) async -> Result<[Recipe], any Error> {
        let apiEndpoint = MealsDbApiEndpoint.getRecipesByCategory(categoryName: categoryName)
        do {
            let recipeDto: RecipesDto = try await apiService.request(apiEndpoint: apiEndpoint)
            return .success(recipeDto.recipes)
        } catch {
            return .failure(error)
        }
    }
    
}
