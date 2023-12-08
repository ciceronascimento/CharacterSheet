//
//  CatsViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import UIKit

class CatsViewController: UIViewController {

    var racas: [CatAPIModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        testAPI()
    }

    func testAPI() {
        Task {
            racas = try await APIManager().getData(apiConfig: CatAPIRoute(aPIRoutes: .breeds))
            for i in racas {
                print(i.name)
            }
        }
    }
}
