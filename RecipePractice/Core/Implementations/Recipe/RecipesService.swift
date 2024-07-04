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
    private var realm: Realm
    
    init() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func fetch(filter: RecipesSort, searchQuery: String? = nil) -> AnyPublisher<[Recipe], Never> {
        var recipes = realm.objects(Recipe.self)
        
        // Фильтрация по запросу
        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            recipes = recipes.filter("title CONTAINS[c] %@", searchQuery)
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
        
        return recipes.publisher.collect().eraseToAnyPublisher()
    }
    
    func add(recipe: Recipe, image: UIImage?) {
        if let image = image {
            if let imagePath = saveImage(image: image, fileName: recipe.id) {
                recipe.image = imagePath
                let fileExists = FileManager.default.fileExists(atPath: imagePath)
                print("File exists at path: \(fileExists)")
            }
        }
        do {
            try realm.write {
                realm.add(recipe)
            }
        } catch let error as NSError {
            print("Failed to add recipe: \(error.localizedDescription)")
        }
    }
    
    func remove(recipe: Recipe) {
        if let imagePath = recipe.image {
            deleteImageFromDocuments(imagePath: imagePath)
        }
        do {
            try realm.write {
                if let existingRecipe = realm.object(ofType: Recipe.self, forPrimaryKey: recipe.id) {
                    realm.delete(existingRecipe)
                } else {
                    print("Recipe not found in database.")
                }
            }
        } catch let error as NSError {
            print("Failed to remove recipe: \(error.localizedDescription)")
        }
    }
    
    func update(recipe: Recipe, image: UIImage?) {
        if let image = image {
            // Удаление старого изображения, если оно существует
            if let oldImagePath = recipe.image {
                deleteImageFromDocuments(imagePath: oldImagePath)
            }
            if let imagePath = saveImage(image: image, fileName: recipe.id) {
                recipe.image = imagePath
            }
        }
        do {
            try realm.write {
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
