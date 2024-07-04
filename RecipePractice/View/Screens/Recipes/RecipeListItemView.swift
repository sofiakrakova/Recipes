//
//  SwiftUIView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 01.07.2024.


import SwiftUI

struct RecipeListItemView: View {
    @State var recipe: Recipe
    
    var body: some View {
        VStack {
            if let imagePath = recipe.image,
                let imageUrl = URL(string: imagePath),
                let imageData = try? Data(contentsOf: imageUrl),
                let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            Text(recipe.title)
                .font(.largeTitle)
                .padding()
            Text("Calories: \(recipe.calories)")
            Text("Total Weight: \(recipe.totalWeight)")
            VStack(alignment: .leading) {
                Text("Ingredients:")
                    .font(.headline)
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("- \(ingredient)")
                }
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}
//
//#Preview {
//    RecipeDetailView()
//}
