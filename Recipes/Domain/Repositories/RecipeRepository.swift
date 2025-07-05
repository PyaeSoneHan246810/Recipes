//
//  RecipeRepository.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

protocol RecipeRepository {
    func getRecipes(by categoryName: String) async -> Result<[Recipe], Error>
    func getRecipeDetails(id: String) async -> Result<RecipeDetails, Error>
    func searchRecipes(with searchText: String) async -> Result<[RecipeDetails], Error>
}
