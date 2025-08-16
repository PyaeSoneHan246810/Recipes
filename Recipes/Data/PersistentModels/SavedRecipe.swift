//
//  Recipe.swift
//  Recipes
//
//  Created by Dylan on 16/8/25.
//

import SwiftData

@Model
class SavedRecipe {
    var id: String
    var name: String?
    var image: String?
    var category: String?
    var area: String?
    var instructions: String?
    var tags: String?
    var youtube: String?
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var ingredient11: String?
    var ingredient12: String?
    var ingredient13: String?
    var ingredient14: String?
    var ingredient15: String?
    var ingredient16: String?
    var ingredient17: String?
    var ingredient18: String?
    var ingredient19: String?
    var ingredient20: String?
    var measure1: String?
    var measure2: String?
    var measure3: String?
    var measure4: String?
    var measure5: String?
    var measure6: String?
    var measure7: String?
    var measure8: String?
    var measure9: String?
    var measure10: String?
    var measure11: String?
    var measure12: String?
    var measure13: String?
    var measure14: String?
    var measure15: String?
    var measure16: String?
    var measure17: String?
    var measure18: String?
    var measure19: String?
    var measure20: String?
    init(id: String, name: String? = nil, image: String? = nil, category: String? = nil, area: String? = nil, instructions: String? = nil, tags: String? = nil, youtube: String? = nil, ingredient1: String? = nil, ingredient2: String? = nil, ingredient3: String? = nil, ingredient4: String? = nil, ingredient5: String? = nil, ingredient6: String? = nil, ingredient7: String? = nil, ingredient8: String? = nil, ingredient9: String? = nil, ingredient10: String? = nil, ingredient11: String? = nil, ingredient12: String? = nil, ingredient13: String? = nil, ingredient14: String? = nil, ingredient15: String? = nil, ingredient16: String? = nil, ingredient17: String? = nil, ingredient18: String? = nil, ingredient19: String? = nil, ingredient20: String? = nil, measure1: String? = nil, measure2: String? = nil, measure3: String? = nil, measure4: String? = nil, measure5: String? = nil, measure6: String? = nil, measure7: String? = nil, measure8: String? = nil, measure9: String? = nil, measure10: String? = nil, measure11: String? = nil, measure12: String? = nil, measure13: String? = nil, measure14: String? = nil, measure15: String? = nil, measure16: String? = nil, measure17: String? = nil, measure18: String? = nil, measure19: String? = nil, measure20: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.category = category
        self.area = area
        self.instructions = instructions
        self.tags = tags
        self.youtube = youtube
        self.ingredient1 = ingredient1
        self.ingredient2 = ingredient2
        self.ingredient3 = ingredient3
        self.ingredient4 = ingredient4
        self.ingredient5 = ingredient5
        self.ingredient6 = ingredient6
        self.ingredient7 = ingredient7
        self.ingredient8 = ingredient8
        self.ingredient9 = ingredient9
        self.ingredient10 = ingredient10
        self.ingredient11 = ingredient11
        self.ingredient12 = ingredient12
        self.ingredient13 = ingredient13
        self.ingredient14 = ingredient14
        self.ingredient15 = ingredient15
        self.ingredient16 = ingredient16
        self.ingredient17 = ingredient17
        self.ingredient18 = ingredient18
        self.ingredient19 = ingredient19
        self.ingredient20 = ingredient20
        self.measure1 = measure1
        self.measure2 = measure2
        self.measure3 = measure3
        self.measure4 = measure4
        self.measure5 = measure5
        self.measure6 = measure6
        self.measure7 = measure7
        self.measure8 = measure8
        self.measure9 = measure9
        self.measure10 = measure10
        self.measure11 = measure11
        self.measure12 = measure12
        self.measure13 = measure13
        self.measure14 = measure14
        self.measure15 = measure15
        self.measure16 = measure16
        self.measure17 = measure17
        self.measure18 = measure18
        self.measure19 = measure19
        self.measure20 = measure20
    }
}

extension SavedRecipe {
    convenience init(from details: RecipeDetails) {
        self.init(
            id: details.id,
            name: details.name,
            image: details.image,
            category: details.category,
            area: details.area,
            instructions: details.instructions,
            tags: details.tags,
            youtube: details.youtube,
            ingredient1: details.ingredient1,
            ingredient2: details.ingredient2,
            ingredient3: details.ingredient3,
            ingredient4: details.ingredient4,
            ingredient5: details.ingredient5,
            ingredient6: details.ingredient6,
            ingredient7: details.ingredient7,
            ingredient8: details.ingredient8,
            ingredient9: details.ingredient9,
            ingredient10: details.ingredient10,
            ingredient11: details.ingredient11,
            ingredient12: details.ingredient12,
            ingredient13: details.ingredient13,
            ingredient14: details.ingredient14,
            ingredient15: details.ingredient15,
            ingredient16: details.ingredient16,
            ingredient17: details.ingredient17,
            ingredient18: details.ingredient18,
            ingredient19: details.ingredient19,
            ingredient20: details.ingredient20,
            
            measure1: details.measure1,
            measure2: details.measure2,
            measure3: details.measure3,
            measure4: details.measure4,
            measure5: details.measure5,
            measure6: details.measure6,
            measure7: details.measure7,
            measure8: details.measure8,
            measure9: details.measure9,
            measure10: details.measure10,
            measure11: details.measure11,
            measure12: details.measure12,
            measure13: details.measure13,
            measure14: details.measure14,
            measure15: details.measure15,
            measure16: details.measure16,
            measure17: details.measure17,
            measure18: details.measure18,
            measure19: details.measure19,
            measure20: details.measure20
        )
    }
    func toRecipeDetails() -> RecipeDetails {
        RecipeDetails(
            id: self.id,
            name: self.name,
            category: self.category,
            area: self.area,
            instructions: self.instructions,
            tags: self.tags,
            image: self.image,
            youtube: self.youtube,
            ingredient1: self.ingredient1,
            ingredient2: self.ingredient2,
            ingredient3: self.ingredient3,
            ingredient4: self.ingredient4,
            ingredient5: self.ingredient5,
            ingredient6: self.ingredient6,
            ingredient7: self.ingredient7,
            ingredient8: self.ingredient8,
            ingredient9: self.ingredient9,
            ingredient10: self.ingredient10,
            ingredient11: self.ingredient11,
            ingredient12: self.ingredient12,
            ingredient13: self.ingredient13,
            ingredient14: self.ingredient14,
            ingredient15: self.ingredient15,
            ingredient16: self.ingredient16,
            ingredient17: self.ingredient17,
            ingredient18: self.ingredient18,
            ingredient19: self.ingredient19,
            ingredient20: self.ingredient20,
            measure1: self.measure1,
            measure2: self.measure2,
            measure3: self.measure3,
            measure4: self.measure4,
            measure5: self.measure5,
            measure6: self.measure6,
            measure7: self.measure7,
            measure8: self.measure8,
            measure9: self.measure9,
            measure10: self.measure10,
            measure11: self.measure11,
            measure12: self.measure12,
            measure13: self.measure13,
            measure14: self.measure14,
            measure15: self.measure15,
            measure16: self.measure16,
            measure17: self.measure17,
            measure18: self.measure18,
            measure19: self.measure19,
            measure20: self.measure20
        )
    }
}
