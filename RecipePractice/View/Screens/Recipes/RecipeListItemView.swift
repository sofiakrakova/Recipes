//
//  SwiftUIView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 01.07.2024.

import SwiftUI
import Combine
import Swinject

struct RecipeListItemView: View {
    @Environment(\.container) var container: Container
    var recipe: Recipe
    var isLocal: Bool
    private var cancellables = Set<AnyCancellable>()
    
    internal init(recipe: Recipe, isLocal: Bool) {
        self.recipe = recipe
        self.isLocal = isLocal
    }

    var body: some View {
        NavigationLink(destination: RecipeDetailView(viewModel: container.resolve(RecipeDetailViewModel.self)!, recipe: recipe, isLocal: isLocal)) {
            VStack {
                RecipeImageView(imagePath: recipe.image)
                Text(recipe.title)
                    .font(.largeTitle)
                if recipe.calories > 0 {
                    Text(String(format: NSLocalizedString(StringCatalog.caloriesFormat, comment: ""), "\(recipe.calories)"))
                }
                if recipe.totalWeight > 0 {
                    Text(String(format: NSLocalizedString(StringCatalog.totalWeightFormat, comment: ""), "\(recipe.totalWeight)"))
                }
                VStack(alignment: .leading) {
                    Text(StringCatalog.ingredients)
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
