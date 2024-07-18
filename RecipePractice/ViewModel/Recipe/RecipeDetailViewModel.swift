//
//  RecipeDetailViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 17.07.2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var isShareSheetShowing = false
    @Published var recipe: Recipe?
    @Published var isLocal: Bool = false
    private let interactor: RecipesInteractorProtocol

    init(interactor: RecipesInteractorProtocol) {
        self.interactor = interactor
    }
    
    func hasInfo() -> Bool {
        guard let recipe = recipe else { return false }
        return recipe.calories > 0 && recipe.totalWeight > 0 && recipe.type != ""
    }
    
    func shareContent() -> String {
        guard let recipe = recipe else { return "" }
        var content = "\(recipe.title)\n\nIngredients:\n"
        for ingredient in recipe.ingredients {
            content += "- \(ingredient)\n"
        }
        return content
    }
    
    func save() {
        guard let recipe = recipe else { return }
        guard let url = URL(string: recipe.image ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else {
                print("Failed to load image from URL")
                return
            }
            DispatchQueue.main.async {
                self.interactor.update(recipe: recipe, image: uiImage)
                self.isLocal = true
            }
        }.resume()
    }
}
