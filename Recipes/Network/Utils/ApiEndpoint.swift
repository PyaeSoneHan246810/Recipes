//
//  ApiEndpoint.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

protocol ApiEndpoint {
    var endpointPath: String { get }
    var httpMethod: HttpMethod { get }
    var httpBody: Data? { get }
    var httpHeaders: [String:String]? { get }
}
