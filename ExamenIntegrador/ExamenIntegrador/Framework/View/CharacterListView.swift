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
                if viewModel.linkToPreviousPage != "" {
                    Button {
                        Task {
                            await viewModel.previousPage()
                        }
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.gray)
                            .padding()
                    }
                } else {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(.lightGray))
                        .padding()
                }
                
                Text("\(viewModel.page)")
                    .foregroundColor(.gray)
                
                // Next
                if viewModel.linkToNextPage != "" {
                    Button {
                        Task {
                            await viewModel.nextPage()
                        }
                    } label: {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.gray)
                            .padding()
                    }
                } else {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color(.lightGray))
                        .padding()
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
