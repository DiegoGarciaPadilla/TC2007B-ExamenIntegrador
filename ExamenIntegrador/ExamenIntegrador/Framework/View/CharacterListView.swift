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
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Buscar", text: $viewModel.searchText)
                    .padding(.vertical, 8)
                    .onChange(of: viewModel.searchText) {
                        Task {
                            if viewModel.searchText != "" {
                                await viewModel.searchCharacters(query: viewModel.searchText)
                                viewModel.isSearching = true
                            } else {
                                viewModel.isSearching = false
                            }
                        }
                    }
            }
            .padding(.horizontal)
            Divider()
                .background(Color.gray)
                .padding(.horizontal)

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
            
            // Paginacion (solo si no está filtrando)
            if viewModel.isSearching == false {
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
