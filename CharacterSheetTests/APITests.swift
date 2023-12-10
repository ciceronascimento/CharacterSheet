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
        mockSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)

        do {
            let _: [DogAPIModel] = try await apiManager.getData(apiConfig: DogAPIConfiguration(aPIRoutes: .breeds))
            XCTFail("Expected to throw an error but did not.")
        } catch {
            // Check if the error is as expected
            guard let urlError = error as? URLError else {
                return XCTFail("Expected URLError but got \(error)")
            }
            XCTAssertEqual(urlError.code, .notConnectedToInternet)
        }
    }
}
