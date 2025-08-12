//
//  DataState.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

enum DataState<T> {
    case idle
    case loading
    case success(data: T)
    case failure(error: Error)
}

extension DataState {
    var isSuccess: Bool {
        if case .success(_) = self {
            return true
        } else {
            return false
        }
    }
}
