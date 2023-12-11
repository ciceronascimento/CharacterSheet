//
//  MockAPIManager.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 11/12/23.
//

import Foundation
@testable import CharacterSheet

class MockAPIManager<T: AnimalData>: APIManagerProtocol {
    var mockResult: [T]?
    var error: APIError?

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
