//
//  ApiServiceError.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

enum ApiServiceError: Error, LocalizedError {
    case invalidUrl
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            "The URL for the API request was invalid."
        }
    }
}
