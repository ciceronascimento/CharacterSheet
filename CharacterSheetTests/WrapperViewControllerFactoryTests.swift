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
        // Arrange
        let container = DIContainer.shared
        container.registerDependencies() // Make sure this uses MockAPIManager

        // Act
        let tabViewController = WrapperViewControllerFactory.make(container: container)

        // Assert
        XCTAssertNotNil(tabViewController, "TabViewController should not be nil")
        XCTAssertTrue(tabViewController.catViewController is PetsViewController<CatAPIModel>, "The first child should be a PetsViewController for CatAPIModel")
        XCTAssertTrue(tabViewController.dogViewController is PetsViewController<DogAPIModel>, "The second child should be a PetsViewController for DogAPIModel")
    }
}
