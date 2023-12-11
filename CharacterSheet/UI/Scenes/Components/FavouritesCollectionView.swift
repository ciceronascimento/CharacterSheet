//
//  FavouritesCollectionView.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation
import UIKit
import SwiftUI

class FavouritesCollectionView: UIViewController {

    var petsViewModel: PetsViewModel!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = createCollectionView()
        view.addSubview(collectionView)
    }

    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 120)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "pets")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
        return collectionView
    }
}

extension FavouritesCollectionView: UICollectionViewDataSource,
                                    UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return petsViewModel.animalData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pets", for: indexPath)

        cell.contentConfiguration = UIHostingConfiguration {
            FavPetsView(petsViewModel: petsViewModel, indice: indexPath.row)
        }
        return cell
    }
}
