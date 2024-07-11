//
//  Recipe.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 01.07.2024.
//

import Foundation
import RealmSwift

class Recipe: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    let ingredients = List<String>()
    @objc dynamic var image: String? = nil
    @objc dynamic var calories: Double = 0.0
    @objc dynamic var totalWeight: Double = 0.0
    @objc dynamic var dateAdded: Date = Date()
    @objc dynamic var type: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String, ingredients: [String], calories: Double, image: String?, totalWeight: Double, type: String) {
        self.init()
        self.title = title
        self.ingredients.append(objectsIn: ingredients)
        self.calories = calories
        self.image = image
        self.totalWeight = totalWeight
        self.type = type
    }
    
    convenience init(recipeData: RecipeDTO) {
        self.init(title: recipeData.strMeal,
                  ingredients: [
                    recipeData.strIngredient1, recipeData.strIngredient2, recipeData.strIngredient3, recipeData.strIngredient4, recipeData.strIngredient5, recipeData.strIngredient6, recipeData.strIngredient7, recipeData.strIngredient8, recipeData.strIngredient9, recipeData.strIngredient10, recipeData.strIngredient11, recipeData.strIngredient12, recipeData.strIngredient13, recipeData.strIngredient14, recipeData.strIngredient15, recipeData.strIngredient16, recipeData.strIngredient17, recipeData.strIngredient18, recipeData.strIngredient19, recipeData.strIngredient20
                  ].compactMap { $0 }.filter { !$0.isEmpty },
                  calories: 0,
                  image: recipeData.strMealThumb,
                  totalWeight: 0,
                  type: recipeData.strCategory ?? "")
        self.id = recipeData.idMeal
        self.dateAdded = Date()
    }
}
