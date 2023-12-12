//
//  APIEnums.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 11/12/23.
//

import Foundation

enum APIRoutes: String {
    case breeds
    case favourites
}

enum APIError: Error {
    case networkError(Error)
    case httpError(Int)
    case decodingError
    case invalidURL
    case unknownError
}
