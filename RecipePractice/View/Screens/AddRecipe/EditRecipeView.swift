import SwiftUI

struct EditRecipeView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: EditRecipeViewModel
    
    init(viewModel: EditRecipeViewModel, recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewModel.loadRecipe(recipe)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField(StringCatalog.title, text: $viewModel.recipe.title)
                    .customTextFieldStyle()
                TextField(StringCatalog.ingredients, text: $viewModel.ingredients)
                    .customTextFieldStyle()
                TextField(StringCatalog.calories, text: $viewModel.calories)
                    .keyboardType(.decimalPad)
                    .customTextFieldStyle()
                TextField(StringCatalog.totalWeight, text: $viewModel.totalWeight)
                    .keyboardType(.decimalPad)
                    .customTextFieldStyle()
                TextField(StringCatalog.type, text: $viewModel.recipe.type)
                    .customTextFieldStyle()
                if let uiImage = viewModel.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                Button("Select Image", action: {viewModel.isImagePickerPresented.toggle()})
                Spacer()
            }
            .navigationTitle("Add Recipe")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: addRecipe, label: {
                Text("Add")
            }))
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented, content: {
            ImagePicker(selectedImage: $viewModel.image)
                .edgesIgnoringSafeArea(.bottom)
        })
    }
    
    private func addRecipe() {
        viewModel.updateRecipe()
        presentationMode.wrappedValue.dismiss()
    }
}
