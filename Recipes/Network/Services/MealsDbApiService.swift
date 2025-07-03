//
//  MealsDbApiService.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

class MealsDbApiService: ApiService {
    var baseUrlString: String
    
    var networkService: NetworkService
    
    init(
        baseUrlString: String = "www.themealdb.com/api/json/v1/1/",
        networkService: NetworkService = DefaultNetworkService.instance
    ) {
        self.baseUrlString = baseUrlString
        self.networkService = networkService
    }
    
    func request<T>(apiEndpoint: ApiEndpoint) async throws -> T where T : Decodable {
        guard let url = URL(string: "\(baseUrlString)\(apiEndpoint.endpointPath)") else {
            throw ApiServiceError.invalidUrl
        }
        let httpMethod = apiEndpoint.httpMethod
        let httpBody = apiEndpoint.httpBody
        let httpHeaders = apiEndpoint.httpHeaders
        let decodedModel: T = try await networkService.request(url: url, httpMethod: httpMethod, httpBody: httpBody, httpHeaders: httpHeaders)
        return decodedModel
    }
    
}
