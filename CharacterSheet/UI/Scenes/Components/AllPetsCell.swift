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
            VStack(alignment: .leading) {
                Text(petsViewModel.animalData[indice].name)
                    .font(.headline)
                Text("Tags: \(petsViewModel.animalData[indice].temperament ?? "Sem dados")")
                    .font(.caption2)
                    .italic()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(Color(.systemGray))

                Text("Origin: \(petsViewModel.animalData[indice].origin ?? "Sem dados")")
                    .font(.callout)
                    .minimumScaleFactor(0.1)
            }
            Spacer()
        }
    }
}

#Preview {
    AllPetsCell(petsViewModel: PetsViewModel(), indice: 1)
}
