//
//  Category.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

struct Category: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let image: String
    let description: String
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
