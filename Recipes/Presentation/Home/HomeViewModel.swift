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
    
    private let getCategoriesUsecase: GetCategoriesUsecase
    
    init(categoryRepository: CategoryRepository) {
        getCategoriesUsecase = GetCategoriesUsecase(repository: categoryRepository)
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
    
    func selectCategory(with name: String?) {
        selectedCategoryName = name
    }
}
