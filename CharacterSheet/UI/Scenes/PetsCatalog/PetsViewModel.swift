//
//  PetsViewModel.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import SwiftUI

class PetsViewModel: ObservableObject {

    @Published var animalData: [AnimalData] = []
    @Published var highlights: [AnimalData] = []
    @Published var petImages: [UIImage]?
    @Published var highlightsImg: [UIImage]?
    @Published var errorMessage: String?

    func convertImages(from animals: [AnimalData]) async throws -> [UIImage] {
        var imagesArray: [UIImage] = []
        for pet in animals {
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

    func convertToImage() async throws -> [UIImage] {
        return try await convertImages(from: animalData)
    }

    func convertHighlightsImages() async throws -> [UIImage] {
        return try await convertImages(from: highlights)
    }

    func updateHighlights() async {
        Task {
            if animalData.count >= 6 {
                highlights = animalData.shuffled().prefix(6).map { $0 }
                highlightsImg = try await convertHighlightsImages()
            } else {
                highlights = animalData
            }
        }
    }

    func fetchPets<T: APIManagerProtocol>(apiManager: T, completion: @escaping () -> Void) where T.T: AnimalData {
        Task {
            do {
                animalData = try await apiManager.fetchRequest()
                petImages = try await convertToImage()
                await updateHighlights()
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
