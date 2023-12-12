//
//  DogAPIModel.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import Foundation

protocol AnimalData: Decodable {
    var name: String { get }
    var lifeSpan: String { get }
    var image: BreedImage? { get }
}

struct DogModel: AnimalData {

    let id: Int
    let name: String
    let lifeSpan: String
    let image: BreedImage?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case lifeSpan = "life_span"
    }

    var imageURL: URL {
        URL(string: self.image!.url!)!
    }
}
