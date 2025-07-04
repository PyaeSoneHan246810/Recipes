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
