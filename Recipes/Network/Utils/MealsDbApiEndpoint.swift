//
//  MealsDbApiEndpoint.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

enum MealsDbApiEndpoint: ApiEndpoint {
    case getCategories
    case getRecipesByCategory(categoryName: String)
    case getRecipeDetails(id: String)
    var endpointPath: String {
        switch self {
        case .getCategories:
            "/categories.php"
        case .getRecipesByCategory(let categoryName):
            "/filter.php?c=\(categoryName)"
        case .getRecipeDetails(let id):
            "/lookup.php?i=\(id)"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCategories:
            .get
        case .getRecipesByCategory(_):
            .get
        case .getRecipeDetails(_):
            .get
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getCategories:
            nil
        case .getRecipesByCategory(_):
            nil
        case .getRecipeDetails(_):
            nil
        }
    }
    
    var httpHeaders: [String : String]? {
        switch self {
        case .getCategories:
            nil
        case .getRecipesByCategory(_):
            nil
        case .getRecipeDetails(_):
            nil
        }
    }
    
}
