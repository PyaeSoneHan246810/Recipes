//
//  MealsDbApiEndpoint.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

enum MealsDbApiEndpoint: ApiEndpoint {
    case getCategories
    var endpointPath: String {
        switch self {
        case .getCategories:
            "/categories.php"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCategories:
            .get
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getCategories:
            nil
        }
    }
    
    var httpHeaders: [String : String]? {
        switch self {
        case .getCategories:
            nil
        }
    }
    
}
