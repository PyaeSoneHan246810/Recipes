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
    
}
