//
//  AddRecipeViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 04.07.2024.
//

import Foundation
import UIKit

class AddRecipeViewModel: ObservableObject {
    let interactor: RecipesInteractorProtocol
    
    @Published var title: String = ""
    @Published var ingredients: String = ""
    @Published var image: UIImage? = nil
    @Published var calories: String = ""
    @Published var totalWeight: String = ""
    @Published var type: String = ""
    @Published var isImagePickerPresented = false

    init(interactor: RecipesInteractorProtocol) {
        self.interactor = interactor
    }
    
    func addRecipe() {
        let newRecipe = Recipe()
        newRecipe.title = title
        newRecipe.ingredients.append(objectsIn: ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) })
        newRecipe.calories = Int(calories) ?? 0
        newRecipe.totalWeight = Int(totalWeight) ?? 0
        newRecipe.type = type
        
        interactor.add(recipe: newRecipe, image: image)
    }
}
