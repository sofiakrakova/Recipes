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
}
