//
//  APIModel.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 07/12/23.
//

import Foundation

struct APIModel: Codable {
    let count: Int?
    let results: [Result]?
}

struct Result: Codable {
    let index: String?
    let name: String
    let url: String
}
