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
        return petsViewModel.petsApiModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allPets", for: indexPath)
        let raca = petsViewModel.petsApiModel[indexPath.row]

        cell.contentConfiguration = UIHostingConfiguration {
            HStack {
                Image(uiImage: petsViewModel.petImages![indexPath.row])
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                Text(raca.name)
                Spacer()
                Button(action: {
                    self.isFav.toggle()
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    print("\(raca.name),  \(self.isFav), \(indexPath)")
                }, label: {
                    Image(systemName: self.isFav ? "star.fill" : "star")
                })
            }
        }
        cell.textLabel?.text = raca.name
        cell.imageView?.image = petsViewModel.petImages?[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
}
