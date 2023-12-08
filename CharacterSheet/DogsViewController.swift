//
//  DogsViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import UIKit

class DogsViewController: UIViewController {
    
    var racas: [DogAPIModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        testAPI()
    }

    func testAPI() {
        Task {
            racas = try await APIManager().getData(apiConfig: DogAPIRoute(aPIRoutes: .breeds))
            for i in racas {
                print(i.name)
            }
        }
    }
}
