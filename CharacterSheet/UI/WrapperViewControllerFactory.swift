//
//  WrapperViewControllerFactory.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation

struct WrapperViewControllerFactory {
    static func make(container: DIContainer) -> TabViewController {
        guard let catAPIManager: APIManager<CatModel> = container.resolve(APIManager<CatModel>.self),
              let dogAPIManager: APIManager<DogModel> = container.resolve(APIManager<DogModel>.self) else {
            fatalError("Dependencies not registered properly")
        }

        let catViewController = PetsViewController<CatModel>(apiManager: catAPIManager)
        let dogViewController = PetsViewController<DogModel>(apiManager: dogAPIManager)

        let tabViewController = TabViewController(catViewController: catViewController,
                                                  dogViewController: dogViewController)
        return tabViewController
    }
}
