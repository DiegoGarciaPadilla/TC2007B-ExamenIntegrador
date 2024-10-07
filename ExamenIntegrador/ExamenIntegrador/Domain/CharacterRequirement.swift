//
//  CharacterRequirement.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import Foundation

protocol CharacterRequirementProtocol {
    func getCharacters() async throws -> [Character]
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
    func getCharacters() async throws -> [Character] {
        return try await repository.getCharacters().items
    }
    
}
