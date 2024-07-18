import SwiftUI
import Swinject
import RealmSwift

struct RecipesView: View {
    @Environment(\.container) var container: Container
    @StateObject var viewModel: RecipesViewModel

    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort by", selection: $viewModel.sort) {
                    Text(StringCatalog.nameOfRRecipe).tag(RecipesSort.byName)
                    Text(StringCatalog.dateOfRRecipe).tag(RecipesSort.byDateAdded)
                    Text(StringCatalog.type).tag(RecipesSort.byType)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                Picker("Search by", selection: $viewModel.searchType) {
                    ForEach(SearchType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                List {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeListItemView(recipe: recipe, isLocal: viewModel.isLocal)
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
                        Button(action: { viewModel.signOut() }, label: {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                        })
                        
                        // Показать кнопку добавления рецепта только для локальной модели
                        if viewModel.isLocal {
                            Button(action: { viewModel.isAddRecipeViewPresented = true }, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.isAddRecipeViewPresented, content: {
                AddRecipeView(viewModel: container.resolve(AddRecipeViewModel.self)!)
                    .onDisappear(perform: {
                        viewModel.fetchRecipes()
                    })
            })
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}
