//
//  DragonBallRepository.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import Foundation

class DragonBallRepository {
    
    // Singleton del Repository
    static let shared = DragonBallRepository()
    
    // Singleton del API Service
    private let apiService: DragonBallAPIService
    
    init(apiService: DragonBallAPIService = DragonBallAPIService()) {
        self.apiService = apiService
    }
    
    // Obtener personajes
    func getCharacters() async throws -> CharacterResponse {
        let url = URL(string: "\(API.baseURL)\(API.Routes.characters)")!
        let response = try await apiService.getCharacters(url: url)
        return response
    }
    
    // Obtener personajes dado un URL del modelo
    func getCharactersFromURL(url: URL) async throws -> CharacterResponse {
        let response = try await apiService.getCharacters(url: url)
        return response
    }
    
}
