//
//  AddRecipeViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 04.07.2024.
//

import Foundation
import UIKit

class AddRecipeViewModel: ObservableObject {
    let service: RecipesServiceProtocol
    
    @Published var title: String = ""
    @Published var ingredients: String = ""
    @Published var image: UIImage? = nil
    @Published var calories: String = ""
    @Published var totalWeight: String = ""
    @Published var type: String = ""
    
    init(service: RecipesServiceProtocol) {
        self.service = service
    }
    
    func addRecipe() {
        let newRecipe = Recipe()
        newRecipe.title = title
        newRecipe.ingredients.append(objectsIn: ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) })
        newRecipe.calories = Double(calories) ?? 0.0
        newRecipe.totalWeight = Double(totalWeight) ?? 0.0
        newRecipe.type = type
        
        service.add(recipe: newRecipe, image: image)
    }
}
