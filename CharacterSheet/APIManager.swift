//
//  APIManager.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 07/12/23.
//

import Foundation

protocol NetworkSession {
    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {
    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await self.data(for: request)
    }
}

struct APIFactory {
    static func makeAPIRequest(apiConfig: APIConfiguration) -> URLRequest {
        let url = URL(string: apiConfig.baseURL + apiConfig.path)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiConfig.headers
        request.httpMethod = "GET"
        return request
    }
}

class APIManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func getData<T: APIModel>(apiConfig: APIConfiguration) async throws -> [T] {
        let request = APIFactory.makeAPIRequest(apiConfig: apiConfig)
        let (data, _) = try await self.session.fetchData(for: request)
        let breedDecoded = try JSONDecoder().decode([T].self, from: data)
        let breedWithImage = breedDecoded.filter { $0.image != nil  && $0.image!.url != nil }
        return breedWithImage
    }
}

protocol APIConfiguration {
    var baseURL: String { get }
    var headers: [String: String] { get }
    var aPIRoutes: APIRoutes { get }
    var path: String { get }
}

enum APIRoutes: String {
    case breeds
    case images
}

extension APIConfiguration where Self: RawRepresentable, Self.RawValue == APIRoutes {
    var path: String {
        return rawValue.rawValue
    }
}

struct DogAPIRoute: APIConfiguration {
    var aPIRoutes: APIRoutes
    var baseURL: String { "https://api.thedogapi.com/v1/" }
    var headers: [String: String] { ["x-api-key": "live_V9dceGDjAuaErdoRcFph8MTyDHtbwAfJ8EEwnukrog1hnoPerRjoEvgGACGX3l9M"] }
    var path: String { aPIRoutes.rawValue }
}

struct CatAPIRoute: APIConfiguration {
    var aPIRoutes: APIRoutes
    var baseURL: String { "https://api.thecatapi.com/v1/" }
    var headers: [String: String] { ["x-api-key": "live_dLyS6QQabRYjUFDnc5L7gxDJ7y0yWDmju0SoeI7ZJ7dKfeG0Apkx1kyZfIxuoKWL"] }
    var path: String { aPIRoutes.rawValue }
}
