//
//  CharacterModel.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import Foundation

struct CharacterResponse: Codable {
    var items: [Character]
    var meta: CharacterMeta
    var links: CharacterLinks
    
}

struct Character: Codable, Identifiable {
    var id: Int
    var name: String
    var ki: String
    var status: String?
    var maxKi: String
    var race: String
    var gender: String
    var description: String
    var image: String
    var affiliation: String
}

struct CharacterMeta: Codable {
    var totalItems: Int
    var itemCount: Int
    var itemsPerPage: Int
    var totalPages: Int
    var currentPage: Int
}

struct CharacterLinks: Codable {
    var first: String
    var previous: String
    var next: String
    var last: String
}
