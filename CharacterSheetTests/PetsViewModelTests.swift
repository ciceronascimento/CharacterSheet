//
//  PetsViewModelTests.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 11/12/23.
//

import XCTest
@testable import CharacterSheet

struct MockAPIModel: AnimalData {
    var id: String
    var name: String
    var lifeSpan: String
    var image: BreedImage?
}

class PetsViewModelTests: XCTestCase {
    var viewModel: PetsViewModel!
    var mockAPIManager: MockAPIManager<MockAPIModel>!

    var mockSession: MockNetworkSession!
    var apiManager: APIManager<MockAPIModel>!
    var configuration: APIConfiguration!

    override func setUp() {
        super.setUp()
        mockSession = MockNetworkSession()
        configuration = CatAPIConfiguration(aPIRoutes: .breeds)
        viewModel = PetsViewModel()
        mockAPIManager = MockAPIManager(session: mockSession, configuration: configuration)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }

    func testFetchPetsSuccess() {
        let mockPets = [MockAPIModel(id: "1",
                                     name: "Test Pet",
                                     lifeSpan: "5 anos",
                                     image: nil),
                        MockAPIModel(id: "2",
                                     name: "Test Pet 2",
                                     lifeSpan: "5anos",
                                     image: nil)]
        mockAPIManager.mockResult = mockPets

           let expectation = XCTestExpectation(description: "FetchPets")
           viewModel.fetchPets(apiManager: mockAPIManager) {
               expectation.fulfill()
           }

           wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(viewModel.animalData.count, mockPets.count, "The number of pets should match the mock data")
        XCTAssertNil(viewModel.errorMessage, "There should be no error message on successful fetch")
    }
//
//    func testFetchPetsFailure() {
//        mockAPIManager.mockError = APIError.networkError(NSError(domain: "", code: 0, userInfo: nil))
//

//        viewModel.fetchPets(apiManager: mockAPIManager)
//

//        XCTAssertTrue(viewModel.petsApiModel.isEmpty, "The pets array should be empty on fetch failure")
//        XCTAssertNotNil(viewModel.errorMessage, "An error message should be set on fetch failure")
//    }
}
