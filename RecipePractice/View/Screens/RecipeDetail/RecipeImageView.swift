//
//  RecipeImageView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 17.07.2024.
//

import SwiftUI

struct RecipeImageView: View {
    var imagePath: String?
    @State var recipeImage: Image?
    
    var body: some View {
        if let image = recipeImage {
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let imageUrl = imagePath {
            fetchImage(from: imageUrl)
        }
        else if let imagePath = imagePath {
            recipeImage = Image.fromPath(imagePath: imagePath)
        }
    }
    
    private func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else {
                print("Failed to load image from URL")
                return
            }
            DispatchQueue.main.async {
                recipeImage = Image(uiImage: uiImage)
            }
        }.resume()
    }
}

struct RecipeInfoView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            if recipe.calories > 0 {
                InfoRowView(title: StringCatalog.calories, value: "\(recipe.calories)")
            }
            if recipe.totalWeight > 0 {
                InfoRowView(title: StringCatalog.totalWeight, value: "\(recipe.totalWeight)")
            }
            if recipe.type != "" {
                InfoRowView(title: StringCatalog.type, value: recipe.type)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}
