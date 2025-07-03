//
//  DefaultNetworkService.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import Foundation

class DefaultNetworkService: NetworkService {
    func request<T>(url: URL, httpMethod: HttpMethod, httpBody: Data?, httpHeaders: [String : String]?) async throws -> T where T : Decodable {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = httpHeaders
        guard let (data, urlResponse) = try? await URLSession.shared.data(for: urlRequest) else {
            throw NetworkServiceError.invalidData
        }
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkServiceError.invalidUrlResponse
        }
        guard 200...299 ~= httpUrlResponse.statusCode else {
            throw NetworkServiceError.invalidHttpStatusCode(httpUrlResponse.statusCode)
        }
        guard let decodedModel = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkServiceError.failedDecoding
        }
        return decodedModel
    }
}
