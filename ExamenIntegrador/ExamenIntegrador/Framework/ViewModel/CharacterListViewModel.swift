//
//  CharacterListViewModel.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    
    // Singleton del requirement
    var characterRequirement: CharacterRequirementProtocol
    
    init(characterRequirement: CharacterRequirementProtocol = CharacterRequirement.shared) {
        self.characterRequirement = characterRequirement
    }

    
    // Variables
    @Published var characters: [Character] = []
    @Published var page: Int = 1
    
    // Obtener personajes
    func getCharacters() async {
        
        do {
            let response = try await characterRequirement.getCharacters()
            characters = response.items
            page = response.meta.currentPage
        } catch {
            print("Error al obtener personajes: \(error)")
        }
        
    }
}
