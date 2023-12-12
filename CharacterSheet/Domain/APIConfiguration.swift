//
//  APIConfiguration.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import Foundation

protocol APIConfiguration {
    var baseURL: String { get }
    var headers: [String: String] { get }
//    var aPIRoutes: APIRoutes { get }
    var apiPath: APIRoutes { get set }
}

enum APIRoutes: String {
    case breeds
    case favourites
}

struct DogAPIConfiguration: APIConfiguration {
    var apiPath: APIRoutes

//    var aPIRoutes: APIRoutes
    var baseURL: String { "https://api.thedogapi.com/v1/" }
    var headers: [String: String] { ["x-api-key": "live_V9dceGDjAuaErdoRcFph8MTyDHtbwAfJ8EEwnukrog1hnoPerRjoEvgGACGX3l9M"]}
//    var apiPath: APIRoutes { .breeds }
}

struct CatAPIConfiguration: APIConfiguration {
    var apiPath: APIRoutes
//    var aPIRoutes: APIRoutes
    var baseURL: String { return "https://api.thecatapi.com/v1/" }
    var headers: [String: String] { return ["x-api-key": "live_dLyS6QQabRYjUFDnc5L7gxDJ7y0yWDmju0SoeI7ZJ7dKfeG0Apkx1kyZfIxuoKWL"] }
//    var apiPath: APIRoutes { .breeds }
}
