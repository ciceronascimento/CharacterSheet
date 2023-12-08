//
//  APIModel.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 07/12/23.
//

import Foundation

struct CatAPIModel: APIModel {

    let id: String
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

struct BreedImage: Decodable {
    let id: String?
    let url: String?
}

struct Result: Codable {
    let index: String?
    let name: String
    let url: String
}
