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
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "pets")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
        return collectionView
    }
}

extension FavouritesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsViewModel.petsApiModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pets", for: indexPath)

        cell.contentConfiguration = UIHostingConfiguration {
            HStack {
                Image(uiImage: petsViewModel.petImages![indexPath.row])
                    .resizable()
                    .frame(width: 100)
                    .scaledToFit()
                    .cornerRadius(10)
            }
        }
        return cell
    }
}
