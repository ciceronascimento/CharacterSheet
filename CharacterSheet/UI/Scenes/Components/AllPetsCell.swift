//
//  AllPetsCell.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 11/12/23.
//

import SwiftUI

struct AllPetsCell: View {
    var petsViewModel: PetsViewModel
    var indice: Int
    var body: some View {
        HStack {
            Image(uiImage: petsViewModel.petImages![indice])
                .resizable()
                .frame(width: 60, height: 60)
                .scaledToFit()
            Text(petsViewModel.petsApiModel[indice].name)
            Spacer()
        }
    }
}

#Preview {
    AllPetsCell(petsViewModel: PetsViewModel(), indice: 1)
}
