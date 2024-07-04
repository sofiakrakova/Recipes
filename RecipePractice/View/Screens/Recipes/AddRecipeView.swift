//
//  AddRecipeView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 02.07.2024.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.presentationMode) var presentationMode
        @StateObject var viewModel: AddRecipeViewModel 
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("Title", text: $viewModel.title)
                        .customTextFieldStyle()
                TextField("Ingredients (comma-separated)", text: $viewModel.ingredients)
                        .customTextFieldStyle()
                TextField("Calories", text: $viewModel.calories)
                        .keyboardType(.decimalPad)
                        .customTextFieldStyle()
                TextField("Total Weight", text: $viewModel.totalWeight)
                        .keyboardType(.decimalPad)
                        .customTextFieldStyle()
                TextField("Type", text: $viewModel.type)
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
        })
    }
    
    private func addRecipe() {
        viewModel.addRecipe()
        presentationMode.wrappedValue.dismiss()
    }
}
