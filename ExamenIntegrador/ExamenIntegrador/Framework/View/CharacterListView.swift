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
            
            // Titulo
            Text("Dragon Ball")
                .font(.title)
            
            // Lista
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
            
            // Paginacion
            HStack {
                Spacer()
                
                // Back
                if true {
                    Button {
                        //
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Text("\(viewModel.page)")
                    .foregroundColor(.gray)
                
                // Next
                if true {
                    Button {
                        //
                    } label: {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Spacer()
            }
            
            
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
