//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI
import Observation

@Observable
class HomeViewModel {
    private(set) var categoriesDataState: DataState<[Category]> = .idle
    private(set) var selectedCategoryName: String? = nil
    private(set) var recipesDataState: DataState<[Recipe]> = .idle
    
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
        case .failure(let error):
            categoriesDataState = .failure(error: EquatableError(error: error))
        }
    }
    
    private func getRecipesByCategory(categoryName: String) async {
        recipesDataState = .loading
        let result = await getRecipesByCategoryUsecase.execute(categoryName: categoryName)
        switch result {
        case .success(let recipes):
            recipesDataState = .success(data: recipes)
        case .failure(let error):
            recipesDataState = .failure(error: EquatableError(error: error))
        }
    }
    
}
