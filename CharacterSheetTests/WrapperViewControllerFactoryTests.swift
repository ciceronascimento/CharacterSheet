//
//  WrapperViewControllerFactoryTests.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 11/12/23.
//

import XCTest
@testable import CharacterSheet

class WrapperViewControllerFactoryTests: XCTestCase {

    func testMake_ReturnsConfiguredTabViewController() {
        let container = DIContainer.shared
        container.registerDependencies()

        let tabViewController = WrapperViewControllerFactory.make(container: container)

        XCTAssertNotNil(tabViewController, "TabViewController should not be nil")
        XCTAssertTrue(tabViewController.catViewController is PetsViewController<CatModel>,
                      "The first child should be a PetsViewController for CatAPIModel")
        XCTAssertTrue(tabViewController.dogViewController is PetsViewController<DogModel>,
                      "The second child should be a PetsViewController for DogAPIModel")
    }
}
