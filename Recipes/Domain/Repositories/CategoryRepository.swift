//
//  CategoryRepository.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

protocol CategoryRepository {
    func getCategories() async -> Result<[Category], Error>
}
