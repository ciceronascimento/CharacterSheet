//
//  ViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 07/12/23.
//

import UIKit

class ViewController: UIViewController {

    var racas: [CatAPIModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        testAPI()
    }


    func testAPI() {
//        Task {
//            racas = try await APIManager().getData(route: APIRoute.races)
//            for i in racas {
//                print(i.name)
//            }
//        }
    }
}

