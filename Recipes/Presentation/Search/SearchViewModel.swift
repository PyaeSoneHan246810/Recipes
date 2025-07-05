//
//  SearchViewModel.swift
//  Recipes
//
//  Created by Dylan on 5/7/25.
//

import Foundation
import Observation

@Observable
class SearchViewModel {
    var searchText: String = ""
    private(set) var searchResultsDataState: DataState<[RecipeDetails]> = .idle
    private let searchRecipesUsecase: SearchRecipesUsecase
    
    init(recipeRepository: RecipeRepository) {
        searchRecipesUsecase = SearchRecipesUsecase(repository: recipeRepository)
    }
    
    var isSearchButtonDisabled: Bool {
        return searchText.trimmed().isEmpty
    }
    
    func searchForResults() async {
        searchResultsDataState = .loading
        let result = await searchRecipesUsecase.execute(searchText: searchText)
        switch result {
        case .success(let recipeDetails):
            searchResultsDataState = .success(data: recipeDetails)
        case .failure(let error):
            searchResultsDataState = .failure(error: error)
        }
    }
    
    func resetSearchResultsDataState() {
        searchResultsDataState = .idle
    }
}
