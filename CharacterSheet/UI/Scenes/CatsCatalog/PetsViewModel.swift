//
//  PetsViewModel.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation
import UIKit

class PetsViewModel: ObservableObject {
    @Published var petsApiModel: [APIModel] = []
    @Published var favPets: [APIModel] = []
    @Published var petImages: [UIImage]?


    func loadImage() {
        Task {
           petImages = try await downloadloadImage()
        }
    }

    func downloadloadImage() async throws -> [UIImage] {
        var imagesArray: [UIImage] = []
        for pet in petsApiModel {
            guard let url = pet.image?.url, let imageUrl = URL(string: url) else {
                continue
            }
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            if let image = UIImage(data: data) {
                imagesArray.append(image)
            }
        }
        return imagesArray
    }

    func fetchPets<T: APIModel>(apiManager: APIManager<T>) {
        Task {
            petsApiModel = try await apiManager.fetchREquest()
            petImages = try await downloadloadImage()
        }
    }
}
