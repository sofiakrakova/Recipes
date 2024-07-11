import SwiftUI
import RealmSwift

struct RecipesView: View {
    @StateObject var viewModel = RecipesViewModel(service: RecipesService())
    
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
                    .onDelete(perform: { indexSet in
                        if let index = indexSet.first {
                            let recipeToDelete = viewModel.recipes[index]
                            viewModel.removeRecipe(recipe: recipeToDelete)
                        }
                    })
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
                        Button(action: { viewModel.isAddRecipeViewPresented = true }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
            .sheet(isPresented: $viewModel.isAddRecipeViewPresented, content: {
                AddRecipeView(viewModel: AddRecipeViewModel(service: viewModel.service))
                    .onDisappear(perform: {
                        viewModel.fetchRecipes()
                    })
            })
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
