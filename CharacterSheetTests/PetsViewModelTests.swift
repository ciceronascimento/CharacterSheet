//
//  PetsViewModelTests.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 11/12/23.
//

import XCTest
@testable import CharacterSheet

class PetsViewModelTests: XCTestCase {
    var viewModel: PetsViewModel!
    var mockAPIManager: MockAPIManager<MockAPIModel>!

    var mockSession: MockNetworkSession!
    var apiManager: APIManager<MockAPIModel>!
    var configuration: APIConfiguration!

    override func setUp() {
        super.setUp()
        mockSession = MockNetworkSession()
        configuration = CatAPIConfiguration(apiPath: .breeds)
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
                                     temperament: "brincalhão",
                                     origin: "Lugar",
                                     image: nil),
                        MockAPIModel(id: "2",
                                     name: "Test Pet2",
                                     temperament: "agitado",
                                     origin: "Lugar",
                                     image: nil)]
        mockAPIManager.mockResult = mockPets

           let expectation = XCTestExpectation(description: "FetchPets")
           viewModel.fetchPets(apiManager: mockAPIManager) {
               expectation.fulfill()
           }

           wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(viewModel.animalData.count, mockPets.count, "O numero de pets deverá ser o mesmo do mock")
        XCTAssertNil(viewModel.errorMessage, "Não deverá ter erro em caso de sucesso")
    }

    func testConvertImagesWithInvalidURL() {
        let viewModel = PetsViewModel()
        let animalData = [CatModel(id: "1", name: "Test Pet", temperament: nil, origin: nil, image: BreedImage(id: "", url: "invalid-url"))]

        let expectation = XCTestExpectation(description: "ConvertImagesWithInvalidURL")
        Task {
            do {
                _ = try await viewModel.convertImages(from: animalData)
                XCTFail("Conversao deve falhar com URL Invalida")
            } catch {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testConvertHighlightsImagesWithInvalidURL() {
        let viewModel = PetsViewModel()

        viewModel.highlights = [CatModel(id: "1", name: "Test Pet", temperament: nil, origin: nil, image: BreedImage(id: "", url: "invalid-url"))]

        let expectation = XCTestExpectation(description: "ConvertHighlightsImagesWithInvalidURL")
        Task {
            do {
                _ = try await viewModel.convertHighlightsImages()
                XCTFail("Conversão deve falhar com URL invalida")
            } catch {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testHandleAPIErrorWithHTTPError() {
        viewModel.handleAPIError(APIError.httpError(404))
        XCTAssertEqual(viewModel.errorMessage, "Erro HTTP: 404", "A mensagem de erro deve ser definida corretamente para erros HTTP")
    }

    func testHandleAPIErrorWithDecodingError() {
        viewModel.handleAPIError(APIError.decodingError)
        XCTAssertEqual(viewModel.errorMessage, "Erro ao processar os dados.", "A mensagem de erro deve ser definida corretamente para erros de decodificação")
    }

    func testHandleAPIErrorWithInvalidURLError() {
        viewModel.handleAPIError(APIError.invalidURL)
        XCTAssertEqual(viewModel.errorMessage, "URL inválida.", "A mensagem de erro deve ser definida corretamente para erros de URL inválida")
    }

    func testHandleAPIErrorWithUnknownError() {
        viewModel.handleAPIError(APIError.unknownError)
        XCTAssertEqual(viewModel.errorMessage, "Erro desconhecido.", "A mensagem de erro deve ser definida corretamente para erros desconhecidos")
    }

    func testHandleAPIErrorWithNonAPIError() {
        viewModel.handleAPIError(NSError(domain: "", code: 0, userInfo: nil))
        XCTAssertEqual(viewModel.errorMessage, "Erro inesperado", "A mensagem de erro deve ser definida corretamente para erros não-API")
    }


}
