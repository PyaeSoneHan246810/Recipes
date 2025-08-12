//
//  RemoteCategoryRepository.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

class RemoteCategoryRepository: CategoryRepository {
    let apiService: ApiService
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    func getCategories() async -> Result<[Category], Error> {
        let apiEndpoint = MealsDbApiEndpoint.getCategories
        do {
            let categoriesDto: CategoriesDto = try await apiService.request(apiEndpoint: apiEndpoint)
            return .success(categoriesDto.categories)
        } catch {
            return .failure(error)
        }
    }
    
}
