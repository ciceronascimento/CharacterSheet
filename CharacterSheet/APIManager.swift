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

protocol APIManagerProtocol {
    associatedtype T: AnimalData
    var configuration: APIConfiguration { get }

    init(session: NetworkSession, configuration: APIConfiguration)
    func fetchRequest() async throws -> [T]
    func postFavPet(animal: AnimalData) async throws -> Bool
    func deleteFavoritePet(favoriteID: Int) async throws -> Bool
}

class APIManager<T: AnimalData>: APIManagerProtocol {
    private let session: NetworkSession
    var configuration: APIConfiguration

    required init(session: NetworkSession = URLSession.shared, configuration: APIConfiguration) {
        self.session = session
        self.configuration = configuration
    }

    func deleteFavoritePet(favoriteID: Int) async throws -> Bool {
        do {
            var request = APIFactory.makeDeleteRequest(apiConfig: configuration)
            if let url = request.url {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.path += "/\(favoriteID)"
                request.url = components?.url
            } else {
                throw APIError.invalidURL
            }

            let (_, response) = try await self.session.fetchData(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknownError
            }
            guard 200...299 ~= httpResponse.statusCode else {
                throw APIError.httpError(httpResponse.statusCode)
            }

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }

        return true
    }

    func postFavPet(animal: AnimalData) async throws -> Bool {
        guard let imageID = animal.image?.id else { return false }
        do {
            var request = APIFactory.makePostRequest(apiConfig: configuration)
            request.httpBody = try JSONEncoder().encode(Favorite(imageID: imageID, subID: "User"))
            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknownError
            }
            guard 200...299 ~= httpResponse.statusCode else {
                throw APIError.httpError(httpResponse.statusCode)
            }

            if let responseHeader = response as? HTTPURLResponse {
                return (responseHeader.statusCode == 200)
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
        return false
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

extension APIConfiguration where Self: RawRepresentable, Self.RawValue == APIRoutes {
    var apiPath: String {
        return rawValue.rawValue
    }
}

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

struct Favorite: Codable {
    let id: Int?
    let imageID: String
    let subID: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageID = "image_id"
        case subID = "sub_id"
    }

    init(id: Int? = nil, imageID: String, subID: String) {
        self.id = id
        self.imageID = imageID
        self.subID = subID
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.imageID, forKey: .imageID)
        try container.encode(self.subID, forKey: .subID)
    }
}
