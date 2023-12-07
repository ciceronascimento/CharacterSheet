//
//  ViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 07/12/23.
//

import UIKit

class ViewController: UIViewController {

    var classe: [Result] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        testAPI()
    }


    func testAPI() {
        Task {
            classe = try await APIManager().getData(route: APIRoute.classes).results ?? []
            print(classe)
        }
    }
}

