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
        container["APIManager<CatModel>"] = APIManager<CatModel>(session: URLSession.shared,
                                                             configuration: CatAPIConfiguration(aPIRoutes: .breeds))
        container["APIManager<DogModel>"] = APIManager<DogModel>(session: URLSession.shared,
                                                             configuration: DogAPIConfiguration(aPIRoutes: .breeds))
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        let key = "\(serviceType)"
        return container[key] as? Service
    }
}
