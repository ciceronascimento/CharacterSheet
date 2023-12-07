//
//  APITests.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 07/12/23.
//

import XCTest
@testable import CharacterSheet

final class APITests: XCTestCase {

    var apiManager: APIManager!
    var mockSession: MockNetworkSession!

    override func setUp() {
        super.setUp()
        mockSession = MockNetworkSession()
        apiManager = APIManager(session: mockSession)
    }

    override func tearDown() {
        apiManager = nil
        mockSession = nil
        super.tearDown()
    }

    func testGetDataFailure() async {
        mockSession.error = NSError(domain: "", code: 0, userInfo: nil)

        do {
            _ = try await apiManager.getData(route: .races)
            XCTFail("The request should have failed")
        }
        catch {
//            XCTAssert(error is )
        }
    }

}
