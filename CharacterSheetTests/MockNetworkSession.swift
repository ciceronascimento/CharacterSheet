//
//  MockNetworkSession.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 07/12/23.
//

import Foundation
@testable import CharacterSheet

class MockNetworkSession: NetworkSession {

    var data: Data?
    var response: URLResponse?
    var error: Error?

    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
