//
//  PetsStackViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import UIKit

extension PetsViewController {
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
extension PetsViewController {
    func addContentToStackView() {

        let favouriteCats = favCollectionView.createCollectionView()
        favouriteCats.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.addArrangedSubview(favouriteCats)

        let allCats = allPetsTableView.createTableView()
        allCats.heightAnchor.constraint(equalToConstant: 500).isActive = true
        stackView.addArrangedSubview(allCats)
    }
}


