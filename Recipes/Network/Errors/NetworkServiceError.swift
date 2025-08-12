//
//  NetworkServiceError.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

enum NetworkServiceError: Error, LocalizedError {
    case invalidData
    case invalidUrlResponse
    case invalidHttpStatusCode(Int)
    case failedDecoding
    var errorDescription: String? {
        switch self {
        case .invalidData:
            "The data returned from the server was invalid."
        case .invalidUrlResponse:
            "The URL response from the server was invalid."
        case .invalidHttpStatusCode(let code):
            "The HTTP status code \(code) was invalid."
        case .failedDecoding:
            "There was an error decoding the data."
        }
    }
}
