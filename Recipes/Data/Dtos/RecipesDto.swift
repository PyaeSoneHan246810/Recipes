//
//  RecipesDto.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

struct RecipesDto: Decodable {
    let recipes: [Recipe]
    enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
}
