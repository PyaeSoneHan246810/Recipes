//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    private(set) var categoriesDataState: DataState<[Category]> = .idle
    private(set) var selectedCategoryName: String? = nil
    private(set) var allRecipesDataState: DataState<[Recipe]> = .idle
    private(set) var recipesByCategoryDataState: DataState<[Recipe]> = .idle
    
    private let getCategoriesUsecase: GetCategoriesUsecase
    private let getRecipesByCategoryUsecase: GetRecipesByCategoryUsecase
    
    init(categoryRepository: CategoryRepository, recipeRepository: RecipeRepository) {
        getCategoriesUsecase = GetCategoriesUsecase(repository: categoryRepository)
        getRecipesByCategoryUsecase = GetRecipesByCategoryUsecase(repository: recipeRepository)
    }
    
    func selectCategory(with name: String?) {
        selectedCategoryName = name
        if let categoryName = selectedCategoryName {
            Task { await getRecipesByCategory(categoryName: categoryName) }
        }
    }
    
    func getCategories() async {
        categoriesDataState = .loading
        let result = await getCategoriesUsecase.execute()
        switch result {
        case .success(let categories):
            categoriesDataState = .success(data: categories)
            await getAllRecipes()
        case .failure(let error):
            categoriesDataState = .failure(error: error)
        }
    }
    
    private func getAllRecipes() async {
        allRecipesDataState = .loading
        var allRecipes: [Recipe] = []
        if case .success(let categories) = categoriesDataState {
            for category in categories {
                let result = await getRecipesByCategoryUsecase.execute(categoryName: category.name)
                switch result {
                case .success(let recipes):
                    allRecipes.append(contentsOf: recipes)
                case .failure(_):
                    allRecipes.append(contentsOf: [])
                }
            }
        }
        let sortedAllRecipes = allRecipes.map {
            var recipe = $0
            recipe.name = recipe.name.trimmed()
            return recipe
        }.sorted { lhs, rhs in
            lhs.name < rhs.name
        }
        allRecipesDataState = .success(data: sortedAllRecipes)
    }
    
    private func getRecipesByCategory(categoryName: String) async {
        recipesByCategoryDataState = .loading
        let result = await getRecipesByCategoryUsecase.execute(categoryName: categoryName)
        switch result {
        case .success(let recipes):
            recipesByCategoryDataState = .success(data: recipes)
        case .failure(let error):
            recipesByCategoryDataState = .failure(error: error)
        }
    }
    
}
