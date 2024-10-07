//
//  CharacterListView.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import SwiftUI

struct CharacterListView: View {
    
    // View Model
    @ObservedObject var viewModel = CharacterListViewModel()
    
    var body: some View {
        
        VStack {
            List(viewModel.characters) { character in
                Text(character.name)
            }
        }.onAppear {
            Task {
                await viewModel.getCharacters()
            }
        }
    }
}

#Preview {
    CharacterListView()
}
