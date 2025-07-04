//
//  DataState.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import Foundation

enum DataState<T: Equatable>: Equatable {
    case idle
    case loading
    case success(data: T)
    case failure(error: EquatableError)
}

struct EquatableError: Equatable {
    let error: Error

    static func == (lhs: EquatableError, rhs: EquatableError) -> Bool {
        return lhs.error.localizedDescription == rhs.error.localizedDescription
    }
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
