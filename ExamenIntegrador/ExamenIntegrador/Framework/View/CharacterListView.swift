//
//  CharacterListView.swift
//  ExamenIntegrador
//
//  Created by Diego Antonio García Padilla on 07/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterListView: View {
    
    // View Model
    @ObservedObject var viewModel = CharacterListViewModel()
    
    var body: some View {
        
        
        VStack {
            
            Text("Dragon Ball")
                .font(.title)
            
            List(viewModel.characters) { character in
                HStack {
                    WebImage(url: URL(string: character.image))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(character.name)
                }
            }.scrollContentBackground(.hidden)
                .background(.white)
            
            
        }.onAppear {
            Task {
                await viewModel.getCharacters()
            }
        }.padding()
    }
}

#Preview {
    CharacterListView()
}
