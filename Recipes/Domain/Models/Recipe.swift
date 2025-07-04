//
//  Recipe.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

struct Recipe: Decodable, Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let image: String
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case image = "strMealThumb"
    }
}

extension Recipe {
    static let sample: Recipe = Recipe(id: "52959", name: "Baked salmon with fennel & tomatoes", image: "https://www.themealdb.com/images/media/meals/1548772327.jpg")
}
