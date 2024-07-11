//
//  NetworkRecipesView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 11.07.2024.
//

import Foundation
import SwiftUI

struct NetworkRecipesView: View {
    @StateObject var viewModel = RecipesViewModel(service: RecipeAPIService())
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort by", selection: $viewModel.sort) {
                    Text("Name").tag(RecipesSort.byName)
                    Text("Date Added").tag(RecipesSort.byDateAdded)
                    Text("Type").tag(RecipesSort.byType)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeListItemView(recipe: recipe)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                }
                .background(Color(UIColor.systemGray6))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Recipes")
                        .font(.title2)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: { try? AuthenticationService.shared.signOut() }, label: {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                        })
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
