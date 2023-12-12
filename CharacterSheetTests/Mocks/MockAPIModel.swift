//
//  MockAPIModel.swift
//  CharacterSheetTests
//
//  Created by Cicero Nascimento on 12/12/23.
//

import Foundation
@testable import CharacterSheet

struct MockAPIModel: AnimalData {
    var id: String
    var name: String
    var temperament: String?
    var origin: String?
    var image: BreedImage?
}
