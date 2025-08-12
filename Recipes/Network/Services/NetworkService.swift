//
//  NetworkService.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

protocol NetworkService {
    func request<T>(url: URL, httpMethod: HttpMethod, httpBody: Data?, httpHeaders: [String:String]?) async throws -> T where T: Decodable
}
