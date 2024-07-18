//
//  RecipesService.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 03.07.2024.
//

import Foundation
import RealmSwift
import Combine
import UIKit

class RecipesService: RecipesServiceProtocol {
    func fetch(filter: RecipesSort, searchQuery: String? = nil, searchType: SearchType = .byName) -> AnyPublisher<[Recipe], Never> {
        return Future { promise in
            DispatchQueue.main.async {
                do {
                    let realm = try Realm()
                    var recipes = realm.objects(Recipe.self)
                    
                    // Фильтрация по запросу
                    if let searchQuery = searchQuery, !searchQuery.isEmpty {
                        switch searchType {
                        case .byName:
                            recipes = recipes.filter("title CONTAINS[c] %@", searchQuery)
                        case .byIngredients:
                            recipes = recipes.filter("ANY ingredients CONTAINS[c] %@", searchQuery)
                        }
                    }
                    
                    // Сортировка по заданному фильтру
                    switch filter {
                    case .byName:
                        recipes = recipes.sorted(byKeyPath: "title", ascending: true)
                    case .byDateAdded:
                        recipes = recipes.sorted(byKeyPath: "dateAdded", ascending: true)
                    case .byType:
                        recipes = recipes.sorted(byKeyPath: "type", ascending: true)
                    }
                    
                    promise(.success(Array(recipes)))
                } catch {
                    print("Failed to fetch recipes: \(error.localizedDescription)")
                    promise(.success([]))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func add(recipe: Recipe, image: UIImage?) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    if let image = image, let imagePath = self.saveImage(image: image, fileName: recipe.id) {
                        recipe.image = imagePath
                    }
                    realm.add(recipe)
                }
            } catch let error as NSError {
                print("Failed to add recipe: \(error.localizedDescription)")
            }
        }
    }
    
    func remove(recipe: Recipe, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                if let imagePath = recipe.image {
                    self.deleteImageFromDocuments(imagePath: imagePath)
                }
                try realm.write {
                    if let existingRecipe = realm.object(ofType: Recipe.self, forPrimaryKey: recipe.id) {
                        realm.delete(existingRecipe)
                    } else {
                        print("Recipe not found in database.")
                    }
                }
                completion()
            } catch let error as NSError {
                print("Failed to remove recipe: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func update(recipe: Recipe, image: UIImage?) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    if let image = image, let oldImagePath = recipe.image {
                        self.deleteImageFromDocuments(imagePath: oldImagePath)
                        if let imagePath = self.saveImage(image: image, fileName: recipe.id) {
                            recipe.image = imagePath
                        }
                    }
                    if realm.object(ofType: Recipe.self, forPrimaryKey: recipe.id) != nil {
                        realm.add(recipe, update: .modified)
                    } else {
                        print("Recipe not found in database.")
                    }
                }
            } catch let error as NSError {
                print("Failed to update recipe: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveImage(image: UIImage, fileName: String) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            print("Error converting image to JPEG")
            return nil
        }
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(fileName).jpeg", conformingTo: .jpeg)
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func deleteImageFromDocuments(imagePath: String) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: imagePath)
        } catch {
            print("Error deleting image: \(error.localizedDescription)")
        }
    }
}
