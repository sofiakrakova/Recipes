import SwiftUI
import Swinject

struct RecipeDetailView: View {
    @Environment(\.container) var container: Container
    @StateObject var viewModel: RecipeDetailViewModel
    
    init(viewModel: RecipeDetailViewModel, recipe: Recipe, isLocal: Bool) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewModel.recipe = recipe
        self.viewModel.isLocal = isLocal
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let recipe = viewModel.recipe {
                        RecipeImageView(imagePath: recipe.image)
                        Text(recipe.title)
                            .font(.largeTitle)
                            .padding()
                        
                        if viewModel.hasInfo() {
                            RecipeInfoView(recipe: recipe)
                        }
                        
                        if recipe.ingredients.count > 0 {
                            IngredientsView(ingredients: Array(recipe.ingredients))
                        }
                        if !viewModel.isLocal {
                            Button(action: { viewModel.save() }, label: {
                                Text("Save")
                            })
                        } else {
                            NavigationLink(destination: EditRecipeView(viewModel: container.resolve(EditRecipeViewModel.self)!, recipe: recipe)) {
                                Text("Edit")
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Recipe Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isShareSheetShowing = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShareSheetShowing, content: {
                ActivityViewController(activityItems: [viewModel.shareContent()])
            })
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
