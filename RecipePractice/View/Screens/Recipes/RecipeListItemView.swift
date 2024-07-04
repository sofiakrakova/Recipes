//
//  SwiftUIView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 01.07.2024.


import SwiftUI

struct RecipeListItemView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            if let imagePath = recipe.image {
                Image.fromPath(imagePath: imagePath)
                    .resizable()
                    .scaledToFit()
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
