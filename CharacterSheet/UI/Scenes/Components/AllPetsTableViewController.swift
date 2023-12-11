//
//  AllPetsViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import UIKit
import SwiftUI

class AllPetsTableViewController: UIViewController {

    var petsViewModel: PetsViewModel!
    var tableView: UITableView!

    private var isFav: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = createTableView()
    }

    func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "allPets")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        self.tableView = tableView
        return tableView
    }

}
extension AllPetsTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Pets"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = petsViewModel.errorMessage {
            return 1
        }
        return petsViewModel.petsApiModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let message = petsViewModel.errorMessage {
            let cell = tableView.dequeueReusableCell(withIdentifier: "allPets", for: indexPath)
            cell.textLabel?.text = message
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "allPets", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            AllPetsCell(petsViewModel: petsViewModel, indice: indexPath.row)
        }
        return cell
    }
}
