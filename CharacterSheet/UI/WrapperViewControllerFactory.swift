//
//  WrapperViewControllerFactory.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation

struct WrapperViewControllerFactory {
    static func make() -> WrapperViewController {
        let catAPIManager = APIManager<CatAPIModel>(configuration: CatAPIConfiguration(aPIRoutes: .breeds))
        let dogAPIManager = APIManager<DogAPIModel>(configuration: DogAPIConfiguration(aPIRoutes: .breeds))
        let viewController = WrapperViewController(
            catViewController: PetsViewController<CatAPIModel>(apiManager: catAPIManager),
            dogViewController: PetsViewController<DogAPIModel>(apiManager: dogAPIManager)
        )

        return viewController
    }
}
