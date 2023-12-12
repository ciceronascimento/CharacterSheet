//
//  APIFactory.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 11/12/23.
//

import Foundation

struct APIFactory {
    private static func makeRequest(apiConfig: APIConfiguration, method: String) -> URLRequest {
        let url = URL(string: apiConfig.baseURL + apiConfig.apiPath.rawValue)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiConfig.headers
        request.httpMethod = method
        return request
    }

    static func makeGetRequest(apiConfig: APIConfiguration) -> URLRequest {
        return makeRequest(apiConfig: apiConfig, method: "GET")
    }

    static func makePostRequest(apiConfig: APIConfiguration) -> URLRequest {
        return makeRequest(apiConfig: apiConfig, method: "POST")
    }

    static func makeDeleteRequest(apiConfig: APIConfiguration) -> URLRequest {
        return makeRequest(apiConfig: apiConfig, method: "DELETE")
    }
}
