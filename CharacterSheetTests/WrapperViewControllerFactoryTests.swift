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

        XCTAssertNotNil(tabViewController, "TabViewController Não pode ser nula")
        XCTAssertTrue(tabViewController.catViewController is PetsViewController<CatModel>,
                      "A primeira viewController é uma PetsViewController para CatAPIModel")
        XCTAssertTrue(tabViewController.dogViewController is PetsViewController<DogModel>,
                      "A segunda viewController é uma PetsViewController para DogAPIModel")
    }

    func testMake_InitialSelectedTab_IsCorrect() {
        let container = DIContainer.shared
        container.registerDependencies()

        let tabViewController = WrapperViewControllerFactory.make(container: container)

        XCTAssertEqual(tabViewController.selectedIndex, 0, "A tab inicial deverá estar no índice 0")
    }

    func testMake_ChildViewControllersCount_IsCorrect() {
        let container = DIContainer.shared
        container.registerDependencies()

        let tabViewController = WrapperViewControllerFactory.make(container: container)

        XCTAssertEqual(tabViewController.viewControllers?.count, 2, "There should be exactly 2 child view controllers")
    }

}
