//
//  RecipeDetailsDto.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

struct RecipeDetailsDto: Decodable {
    let details: [RecipeDetails]
    enum CodingKeys: String, CodingKey {
        case details = "meals"
    }
}
