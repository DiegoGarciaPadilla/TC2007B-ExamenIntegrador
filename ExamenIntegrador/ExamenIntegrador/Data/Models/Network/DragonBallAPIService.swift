//
//  DragonBallAPIService.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import Alamofire
import Foundation

class DragonBallAPIService {
    
    // Obtener todos los personajes
    func getCharacters(url: URL) async throws -> CharacterResponse {
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        
        do {
            let response = try await AF.request(url, method: .get, headers: header)
                .validate()
                .serializingDecodable(CharacterResponse.self)
                .value
            
            return response
        } catch {
            print("Error al obtener los personajes: \(error)")
            throw error
        }
        
    }
    
    // Filtrar personajes
    func getFilteredCharacters(url: URL, filter: String) async throws -> [Character] {
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        
        let params: Parameters = [
            "name": filter
        ]
        
        do {
            let response = try await AF.request(url, method: .get, parameters: params, headers: header)
                .validate()
                .serializingDecodable([Character].self)
                .value
            
            return response
        } catch {
            print("Error al obtener los personajes: \(error)")
            throw error
        }
        
    }
    
}
