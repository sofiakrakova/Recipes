//
//  EditRecipeViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 18.07.2024.
//

import Foundation
import UIKit
import SwiftUI

class EditRecipeViewModel: ObservableObject {
    private let interactor: RecipesInteractorProtocol
    
    @Published var recipe: Recipe = Recipe()
    @Published var image: UIImage? = nil
    @Published var ingredients: String = ""
    @Published var calories: String = ""
    @Published var totalWeight: String = ""
    @Published var isImagePickerPresented = false
    
    init(interactor: RecipesInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadRecipe(_ recipe: Recipe) {
        self.recipe = recipe
        self.ingredients = recipe.ingredients.joined(separator: ",")
        self.image = UIImage.fromPath(imagePath: recipe.image ?? "")
    }
    
    func updateRecipe() {
        let newRecipe = Recipe()
        newRecipe.id = recipe.id
        newRecipe.title = recipe.title
        newRecipe.ingredients.append(objectsIn: ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) })
        newRecipe.calories = Int(calories) ?? 0
        newRecipe.totalWeight = Int(totalWeight) ?? 0
        newRecipe.type = recipe.type
        
        interactor.update(recipe: newRecipe, image: image)
    }
}
