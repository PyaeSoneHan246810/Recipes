//
//  GetCategoriesDto.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

struct CategoriesDto: Decodable {
    let categories: [Category]
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}
