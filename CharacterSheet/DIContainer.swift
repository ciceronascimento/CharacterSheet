//
//  DIContainer.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 11/12/23.
//

import Foundation

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
