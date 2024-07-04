//
//  RecipesView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 02.07.2024.
//

import SwiftUI
import RealmSwift

struct RecipesView: View {
    @StateObject var viewModel = RecipesViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchQuery)
                .padding(.horizontal)
            
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
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        let recipeToDelete = viewModel.recipes[index]
                        viewModel.removeRecipe(recipe: recipeToDelete)
                    }
                })
            }
        }
        .navigationTitle("Recipes")
        .navigationBarItems(trailing: Button(action: { viewModel.isAddRecipeViewPresented = true }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $viewModel.isAddRecipeViewPresented, content: {
            AddRecipeView(viewModel: AddRecipeViewModel(service: viewModel.service))
                .onDisappear(perform: {
                    viewModel.fetchRecipes()
                })
        })
    }
}
