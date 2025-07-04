//
//  RecipeError.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

enum RecipeError: Error, LocalizedError {
    case recipeNotFound
    var errorDescription: String? {
        switch self {
        case .recipeNotFound:
            "There is no recipe available."
        }
    }
}
