//
//  WrapperViewControllerFactoryTests.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 11/12/23.
//

import XCTest
@testable import CharacterSheet

class WrapperViewControllerFactoryTests: XCTestCase {

    func testMakeFunction() {
        let tabViewController = WrapperViewControllerFactory.make()

        // Verifica se TabViewController é do tipo esperado
        XCTAssertNotNil(tabViewController, "TabViewController não deve ser nil")
//        XCTAssertTrue(tabViewController is TabViewController, "Deve ser uma instância de TabViewController")

        // Verifica os ViewControllers dentro do TabViewController
        guard let catViewController = tabViewController.catViewController as? PetsViewController<CatAPIModel>,
              let dogViewController = tabViewController.dogViewController as? PetsViewController<DogAPIModel> else {
            XCTFail("Os ViewControllers devem ser do tipo correto")
            return
        }

        // Verifica as configurações da API para CatAPIManager
        XCTAssertEqual(catViewController.apiManager.configuration.baseURL, "https://api.thecatapi.com/v1/",
                       "URL base da CatAPI deve ser correta")
        XCTAssertEqual(catViewController.apiManager.configuration.aPIRoutes, .breeds,
                       "APIRoutes da CatAPI deve ser 'breeds'")

        // Verifica as configurações da API para DogAPIManager
        XCTAssertEqual(dogViewController.apiManager.configuration.baseURL,
                       "https://api.thedogapi.com/v1/", "URL base da DogAPI deve ser correta")
        XCTAssertEqual(dogViewController.apiManager.configuration.aPIRoutes,
                       .breeds, "APIRoutes da DogAPI deve ser 'breeds'")
    }
}
