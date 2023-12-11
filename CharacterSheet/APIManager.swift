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
        do {
            let (data, response) = try await self.data(for: request)
            return (data, response)
        } catch {
            throw APIError.networkError(error)
        }
    }
}

enum APIError: Error {
    case networkError(Error)
    case httpError(Int)
    case decodingError
    case invalidURL
    case unknownError
}

class APIManager<T: APIModel> {
    private let session: NetworkSession
    var configuration: APIConfiguration

    init(session: NetworkSession = URLSession.shared, configuration: APIConfiguration) {
        self.session = session
        self.configuration = configuration
    }

    func fetchRequest() async throws -> [T] {
        do {
             let request = APIFactory.makeGetRequest(apiConfig: configuration)
             let (data, response) = try await self.session.fetchData(for: request)

             guard let httpResponse = response as? HTTPURLResponse else {
                 throw APIError.unknownError
             }
             guard 200...299 ~= httpResponse.statusCode else {
                 throw APIError.httpError(httpResponse.statusCode)
             }

             do {
                 let breedDecoded = try JSONDecoder().decode([T].self, from: data)
                 let breedWithImage = breedDecoded.filter { $0.image != nil && $0.image!.url != nil }
                 return breedWithImage
             } catch {
                 throw APIError.decodingError
             }
         } catch let error as APIError {
             throw error
         } catch {
             throw APIError.networkError(error)
         }
    }
}

enum APIRoutes: String {
    case breeds
    case favorites
}

struct APIFactory {
    static func makeGetRequest(apiConfig: APIConfiguration) -> URLRequest {
        let url = URL(string: apiConfig.baseURL + apiConfig.path)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiConfig.headers
        request.httpMethod = "GET"
        return request
    }
}

extension APIConfiguration where Self: RawRepresentable, Self.RawValue == APIRoutes {
    var path: String {
        return rawValue.rawValue
    }
}
