//
//  CharacterRequirement.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import Foundation

protocol CharacterRequirementProtocol {
    func getCharacters() async throws -> CharacterResponse
    func getCharactersFromURL(url: URL) async throws -> CharacterResponse
}

class CharacterRequirement: CharacterRequirementProtocol {
    
    // Singleton
    static let shared = CharacterRequirement()
    
    // Singleton del Repository
    let repository: DragonBallRepository
    
    init(repository: DragonBallRepository = DragonBallRepository.shared) {
        self.repository = repository
    }
    
    // Obtener personajes
    func getCharacters() async throws -> CharacterResponse {
        return try await repository.getCharacters()
    }
    
    // Obtener personajes dado un URL del modelo
    func getCharactersFromURL(url: URL) async throws -> CharacterResponse {
        let response = try await repository.getCharactersFromURL(url: url)
        return response
    }
    
}
