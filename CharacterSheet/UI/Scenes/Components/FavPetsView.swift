//
//  FavPetsView.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 11/12/23.
//

import SwiftUI

struct FavPetsView: View {
    var petsViewModel: PetsViewModel
    var indice: Int
    var body: some View {
        HStack {
            ZStack {
                Image(uiImage: petsViewModel.petImages![indice])
                    .resizable()
                    .frame(width: 130)
                    .scaledToFit()
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Material.ultraThinMaterial)
                        .frame(height: 35)
                        .overlay {
                            Text(petsViewModel.animalData[indice].name)
                                .padding(.horizontal, 10)
                                .minimumScaleFactor(0.1)
                                .padding(2)
                        }
                }
            }
        }
    }
}
