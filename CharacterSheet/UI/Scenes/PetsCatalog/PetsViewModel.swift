//
//  PetsViewModel.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import SwiftUI

class PetsViewModel: ObservableObject {

    @Published var animalData: [AnimalData] = []
    @Published var favPets: [AnimalData] = []
    @Published var petImages: [UIImage]?
    @Published var errorMessage: String?

    func convertToImage() async throws -> [UIImage] {
        var imagesArray: [UIImage] = []
        for pet in animalData {
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

    func fetchPets<T: APIManagerProtocol>(apiManager: T, completion: @escaping () -> Void) where T.T: AnimalData {
        Task {
            do {
                animalData = try await apiManager.fetchRequest()
                petImages = try await convertToImage()
                completion()
            } catch {
                handleAPIError(error)
                completion()
            }
        }
    }

    func handleAPIError(_ error: Error) {
        if let apiError = error as? APIError {
            switch apiError {
            case .networkError:
                errorMessage = "Problema de conexão com a internet. Por favor reinicie o aplicativo"
            case .httpError(let statusCode):
                errorMessage = "Erro HTTP: \(statusCode)"
            case .decodingError:
                errorMessage = "Erro ao processar os dados."
            case .invalidURL:
                errorMessage = "URL inválida."
            case .unknownError:
                errorMessage = "Erro desconhecido."
            }
        } else {
            errorMessage = "Erro inesperado"
        }
    }
}
