//
//  APITests.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 07/12/23.
//

import XCTest
@testable import CharacterSheet


class APIManagerTests: XCTestCase {

    let jsonString = """
    [
        {
            "id": "affepinscher01",
            "name": "Affenpinscher",
            "life_span": "10 - 12 years",
            "image": {
                "id": "img01",
                "url": "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"
            }
        }
    ]
    """

    var mockSession: MockNetworkSession!
    var apiManager: APIManager<CatModel>!
    var configuration: APIConfiguration!
    override func setUp() {
        super.setUp()
        mockSession = MockNetworkSession()
        configuration = CatAPIConfiguration(apiPath: .breeds)
        apiManager = APIManager(session: mockSession, configuration: configuration)
    }

    override func tearDown() {
        mockSession = nil
        apiManager = nil
        configuration = nil
        super.tearDown()
    }

    func testFetchRequestSuccess() async {
        guard let data = jsonString.data(using: .utf8) else {
            XCTFail("Falha ao converter JSON string em Data")
            return
        }

        mockSession.data = data
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)!

        do {
            let result = try await apiManager.fetchRequest()
            XCTAssertEqual(result.count, 1, "O resultado deve conter 1 item")

            let firstItem = result.first
            XCTAssertNotNil(firstItem, "O primeiro item não deve ser nil")

            XCTAssertEqual(firstItem?.id, "affepinscher01", "ID deve corresponder")
            XCTAssertEqual(firstItem?.name, "Affenpinscher", "Nome deve corresponder")
            XCTAssertEqual(firstItem?.lifeSpan, "10 - 12 years", "Life span deve corresponder")

            XCTAssertNotNil(firstItem?.image, "Imagem não deve ser nil")
            XCTAssertEqual(firstItem?.image?.url, "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg",
                           "URL da imagem deve corresponder")
        } catch {
            XCTFail("Erro ao buscar dados: \(error)")
        }
    }

    func testFetchRequestEmptyData() async {
        mockSession.data = Data()

        do {
            _ = try await apiManager.fetchRequest()
            XCTFail("Deveria ter falhado com dados vazios")
        } catch {
            XCTAssertNotNil(error, "Erro esperado com dados vazios")
        }
    }

    func testFetchRequestInvalidJSON() async {
        mockSession.data = "Invalid JSON".data(using: .utf8)

        do {
            _ = try await apiManager.fetchRequest()
            XCTFail("Deveria ter falhado com JSON inválido")
        } catch {
            XCTAssertNotNil(error, "Erro esperado com JSON inválido")
        }
    }

    func testFetchRequestInvalidURL() async {
        mockSession.response = HTTPURLResponse(url: URL(string: "https://invalidurl.com")!,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)!

        do {
            _ = try await apiManager.fetchRequest()
            XCTFail("Deveria ter falhado com URL inválida")
        } catch {
            XCTAssertNotNil(error, "Erro esperado com URL inválida")
        }
    }

    func testFetchRequestServerInternalError() async {
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                               statusCode: 500,
                                               httpVersion: nil,
                                               headerFields: nil)!

        do {
            _ = try await apiManager.fetchRequest()
            XCTFail("Deveria ter falhado com erro interno do servidor")
        } catch {
            XCTAssertNotNil(error, "Erro esperado com erro interno do servidor")
        }
    }

    func testFetchRequestNoInternetConnection() async {
        mockSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)

        do {
            _ = try await apiManager.fetchRequest()
            XCTFail("Deveria ter falhado sem conexão com a internet")
        } catch {
            XCTAssertNotNil(error, "Erro esperado sem conexão com a internet")
        }
    }

    func testFetchRequestHTTPRedirection() async {
        mockSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                               statusCode: 302,
                                               httpVersion: nil,
                                               headerFields: ["Location": "https://redirectedexample.com"])!

        do {
            _ = try await apiManager.fetchRequest()
            XCTFail("Deveria ter falhado ou tratado o redirecionamento HTTP")
        } catch {
            XCTAssertNotNil(error, "Erro esperado ou tratamento de redirecionamento HTTP")
        }
    }
}
