//
//  WrapperViewControllerFactory.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation

struct WrapperViewControllerFactory {
    static func make(container: DIContainer) -> TabViewController {
        guard let catAPIManager: APIManager<CatAPIModel> = container.resolve(APIManager<CatAPIModel>.self),
              let dogAPIManager: APIManager<DogAPIModel> = container.resolve(APIManager<DogAPIModel>.self) else {
            fatalError("Dependencies not registered properly")
        }

        let catViewController = PetsViewController<CatAPIModel>(apiManager: catAPIManager)
        let dogViewController = PetsViewController<DogAPIModel>(apiManager: dogAPIManager)

        let tabViewController = TabViewController(catViewController: catViewController,
                                                  dogViewController: dogViewController)

        return tabViewController
    }
}

class DIContainer {
    static let shared = DIContainer()

    private var container = [String: Any]()

    private init() {}

    func registerDependencies() {
        container["APIManager<CatAPIModel>"] = APIManager<CatAPIModel>(session: URLSession.shared,
                                                             configuration: CatAPIConfiguration(aPIRoutes: .breeds))
        container["APIManager<DogAPIModel>"] = APIManager<DogAPIModel>(session: URLSession.shared,
                                                             configuration: DogAPIConfiguration(aPIRoutes: .breeds))
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        let key = "\(serviceType)"
        return container[key] as? Service
    }
}
