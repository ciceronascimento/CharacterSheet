//
//  WrapperViewControllerFactory.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation

struct WrapperViewControllerFactory {
    static func make() -> TabViewController {
        let catAPIManager = APIManager<CatAPIModel>(configuration: CatAPIConfiguration(aPIRoutes: .breeds))
        let dogAPIManager = APIManager<DogAPIModel>(configuration: DogAPIConfiguration(aPIRoutes: .breeds))

        let catViewControler = PetsViewController<CatAPIModel>(apiManager: catAPIManager)
        let dogViewController = PetsViewController<DogAPIModel>(apiManager: dogAPIManager)

        let tabViewController = TabViewController( catViewController: catViewControler,
                                                   dogViewController: dogViewController)
        return tabViewController
    }
}
