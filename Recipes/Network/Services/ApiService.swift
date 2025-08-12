//
//  ApiService.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

protocol ApiService {
    var baseUrlString: String { get }
    var networkService: NetworkService { get }
    func request<T>(apiEndpoint: ApiEndpoint) async throws -> T where T: Decodable
}
