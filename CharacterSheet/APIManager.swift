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

        let baseURL = "https://api.thedogapi.com/v1/"
        let url = URL(string: baseURL + route.rawValue)!
        var request = URLRequest(url: url)

// MARK: - For cat api
//        let baseURL = "https://api.thecatapi.com/v1/"
//        request.allHTTPHeaderFields = [
//            "x-api-key": "live_dLyS6QQabRYjUFDnc5L7gxDJ7y0yWDmju0SoeI7ZJ7dKfeG0Apkx1kyZfIxuoKWL"
//        ]

        request.allHTTPHeaderFields = [
            "x-api-key": "live_V9dceGDjAuaErdoRcFph8MTyDHtbwAfJ8EEwnukrog1hnoPerRjoEvgGACGX3l9M"
        ]

        request.httpMethod = "GET"
        return request
    }
}

class APIManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func getData(route: APIRoute) async throws -> [APIModel] {
        let request = APIFactory.makeAPIRequest(route: route)
        let (data, _) = try await session.fetchData(for: request)
        print(data)
        let breedDecoded = try JSONDecoder().decode([APIModel].self, from: data)
        let breedWithImage = breedDecoded.filter { $0.image != nil  && $0.image!.url != nil}
        return breedWithImage
    }

    func postData() {

    }
}

enum APIRoute: String {
    case races = "breeds"
    case favourites = "favourites"
}
