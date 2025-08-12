//
//  RemoteRecipeRepository.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

class RemoteRecipeRepository: RecipeRepository {
    let apiService: ApiService
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    func getRecipes(by categoryName: String) async -> Result<[Recipe], Error> {
        let apiEndpoint = MealsDbApiEndpoint.getRecipesByCategory(categoryName: categoryName)
        do {
            let recipeDto: RecipesDto = try await apiService.request(apiEndpoint: apiEndpoint)
            return .success(recipeDto.recipes)
        } catch {
            return .failure(error)
        }
    }
    func getRecipeDetails(id: String) async -> Result<RecipeDetails, Error> {
        let apiEndpoint = MealsDbApiEndpoint.getRecipeDetails(id: id)
        do {
            let recipeDetailsDto: RecipeDetailsDto = try await apiService.request(apiEndpoint: apiEndpoint)
            if let recipeDetails = recipeDetailsDto.details?.first {
                return .success(recipeDetails)
            } else {
                return .failure(RecipeError.recipeNotFound)
            }
        } catch {
            return .failure(error)
        }
    }
    func searchRecipes(with searchText: String) async -> Result<[RecipeDetails], Error> {
        let apiEndpoint = MealsDbApiEndpoint.searchRecipes(searchText: searchText)
        do {
            let recipeDetailsDto: RecipeDetailsDto = try await apiService.request(apiEndpoint: apiEndpoint)
            return .success(recipeDetailsDto.details ?? [])
        } catch {
            return .failure(error)
        }
    }
}
