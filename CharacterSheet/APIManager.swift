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

    private func originalData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await self.data(for: request)
    }
}

struct APIFactory {
    static func makeAPIRequest(route: APIRoute) -> URLRequest {
        let baseURL = "https://www.dnd5eapi.co/api/"
        let url = URL(string: baseURL + route.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

class APIManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func getData(route: APIRoute) async throws -> APIModel {
        let request = APIFactory.makeAPIRequest(route: route)
        let (data, _) = try await session.fetchData(for: request)
        return try JSONDecoder().decode(APIModel.self, from: data)
    }
}

enum APIRoute: String {
    case races = "races"
    case classes = "classes"
}
