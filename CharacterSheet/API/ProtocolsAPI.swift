//
//  ProtocolsAPI.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 11/12/23.
//

import Foundation

protocol NetworkSession {
    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse)
}

protocol APIManagerProtocol {
    associatedtype T: AnimalData
    var configuration: APIConfiguration { get }

    init(session: NetworkSession, configuration: APIConfiguration)
    func fetchRequest() async throws -> [T]
    func postFavPet(animal: AnimalData) async throws -> Bool
    func deleteFavoritePet(favoriteID: Int) async throws -> Bool
}


