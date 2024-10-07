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
    @Published var linkToNextPage: String = ""
    @Published var linkToPreviousPage: String = ""
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    // Obtener personajes
    @MainActor
    func getCharacters() async {
        do {
            // Obtener respuesta
            let response = try await characterRequirement.getCharacters()
            
            // Obtener datos de la respuesta
            characters = response.items
            page = response.meta.currentPage
            linkToNextPage = response.links.next ?? ""
            linkToPreviousPage = response.links.previous ?? ""
            
        } catch {
            print("Error al obtener personajes: \(error)")
        }
        
    }
    
    // Ir a la página siguiente
    @MainActor
    func nextPage() async {
        
        // Comprobar si existe una siguiente página
        if linkToNextPage == "" {
            return
        }
        
        do {
            // Obtener respuesta
            let response = try await characterRequirement.getCharactersFromURL(url: URL(string: self.linkToNextPage)!)
            
            // Obtener datos de la respuesta
            characters = response.items
            page = response.meta.currentPage
            linkToNextPage = response.links.next ?? ""
            linkToPreviousPage = response.links.previous ?? ""
        } catch {
            print("Error al obtener personajes: \(error)")
        }
        
    }
    
    // Ir a la página anterior
    @MainActor
    func previousPage() async {
        
        // Comprobar si existe una siguiente página
        if linkToPreviousPage == "" {
            return
        }
        
        do {
            // Obtener respuesta
            let response = try await characterRequirement.getCharactersFromURL(url: URL(string: self.linkToPreviousPage)!)
            
            // Obtener datos de la respuesta
            characters = response.items
            page = response.meta.currentPage
            linkToNextPage = response.links.next ?? ""
            linkToPreviousPage = response.links.previous ?? ""
        } catch {
            print("Error al obtener personajes: \(error)")
        }
        
    }
    
    @MainActor
    func searchCharacters(query: String) async {
        do {
            // Obtener respuesta
            let response = try await characterRequirement.getFiltredCharacters(filter: query)
            
            // Obtener datos de la respuesta
            characters = response
            page = 1
            linkToNextPage = ""
            linkToPreviousPage = ""
        } catch {
            print("Error al obtener personajes: \(error)")
        }
    }

}
