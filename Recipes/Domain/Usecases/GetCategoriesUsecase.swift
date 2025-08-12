//
//  GetCategoriesUsecase.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

class GetCategoriesUsecase: CategoryRepositoryUsecase {
    
    var repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[Category], Error> {
        return await repository.getCategories()
    }
    
}
