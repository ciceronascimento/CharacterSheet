//
//  MockAPIManager.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 11/12/23.
//

import Foundation
@testable import CharacterSheet

class MockAPIManager<T: AnimalData>: APIManagerProtocol {
    func postFavPet(animal: CharacterSheet.AnimalData) async throws -> Bool {
        if let error = error {
            throw error
        }
        return mockPostSuccess
    }

    func deleteFavoritePet(favoriteID: Int) async throws -> Bool {
        if let error = error {
              throw error
          }
          return mockDeleteSuccess
    }

    var mockResult: [T]?
    var error: APIError?

    var mockPostSuccess: Bool = false
    var mockDeleteSuccess: Bool = false

    private let session: NetworkSession
    var configuration: APIConfiguration

    required init(session: NetworkSession, configuration: APIConfiguration) {
        self.session = session
        self.configuration = configuration
    }

    func fetchRequest() async throws -> [T] {
        if let error = error {
            throw error
        }
        guard let result = mockResult else {
            throw APIError.unknownError
        }
        return result
    }
}
