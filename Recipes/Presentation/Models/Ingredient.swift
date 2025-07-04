//
//  Ingredient.swift
//  Recipes
//
//  Created by Dylan on 5/7/25.
//

import Foundation

struct Ingredient: Identifiable {
    let name: String
    let measure: String
    var id: String {
        name
    }
}
