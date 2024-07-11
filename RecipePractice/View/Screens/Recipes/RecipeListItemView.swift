//
//  SwiftUIView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 01.07.2024.


import SwiftUI

struct RecipeListItemView: View {
    var recipe: Recipe
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            VStack {
                if let imagePath = recipe.image {
                    Image.fromPath(imagePath: imagePath)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                }
                Text(recipe.title)
                    .font(.largeTitle)
                Text("Calories: \(recipe.calories, specifier: "%.1f")")
                Text("Total Weight: \(recipe.totalWeight, specifier: "%.1f")")
                VStack(alignment: .leading) {
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("- \(ingredient)")
                    }
                }
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
