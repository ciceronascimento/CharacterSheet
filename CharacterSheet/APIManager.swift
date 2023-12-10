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

class APIManager<T: APIModel> {
    private let session: NetworkSession
    var configuration: APIConfiguration

    init(session: NetworkSession = URLSession.shared, configuration: APIConfiguration) {
        self.session = session
        self.configuration = configuration
    }

    func fetchREquest() async throws -> [T] {
//        guard let config = configuration else { return }
        let request = APIFactory.makeAPIGetRequest(apiConfig: configuration)
        let (data, _) = try await self.session.fetchData(for: request)
        let breedDecoded = try JSONDecoder().decode([T].self, from: data)
        let breedWithImage = breedDecoded.filter { $0.image != nil  && $0.image!.url != nil }
        return breedWithImage
    }

    //    func getData(apiConfig: APIConfiguration) async throws -> [T] {
    //        let request = APIFactory.makeAPIRequest(apiConfig: apiConfig)
    //        let (data, _) = try await self.session.fetchData(for: request)
    //        let breedDecoded = try JSONDecoder().decode([T].self, from: data)
    //        let breedWithImage = breedDecoded.filter { $0.image != nil  && $0.image!.url != nil }
    //        return breedWithImage
    //    }

}

enum APIRoutes: String {
    case breeds
    case images
    case favourites
}

struct APIFactory {
    static func makeAPIGetRequest(apiConfig: APIConfiguration) -> URLRequest {
        let url = URL(string: apiConfig.baseURL + apiConfig.path)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiConfig.headers
        request.httpMethod = "GET"
        return request
    }

    static func makeAPIPostRequest(apiConfig: APIConfiguration) -> URLRequest {
        let url = URL(string: apiConfig.baseURL + apiConfig.path)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiConfig.headers
        request.httpMethod = "POST"
        return request
    }
}

extension APIConfiguration where Self: RawRepresentable, Self.RawValue == APIRoutes {
    var path: String {
        return rawValue.rawValue
    }
}
