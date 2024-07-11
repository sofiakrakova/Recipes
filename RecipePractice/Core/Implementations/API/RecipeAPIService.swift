//
//  RecipeAPIService.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 11.07.2024.
//

import Foundation
import Moya
import UIKit
import Combine

class RecipeAPIService: RecipesServiceProtocol {
    private let provider = MoyaProvider<RecipeAPI>()

    func fetch(filter: RecipesSort, searchQuery: String?) -> AnyPublisher<[Recipe], Never> {
        Future<[Recipe], Never> { promise in
            self.provider.request(.getRecipes) { result in
                switch result {
                case .success(let response):
                    do {
                        
                        let recipesData = try JSONDecoder().decode(MealResponse.self, from: response.data)
                        var recipes = recipesData.meals.map { Recipe(recipeData: $0) }
                            
                        if let searchQuery = searchQuery, !searchQuery.isEmpty {
                            recipes = recipes.filter { $0.title.contains(searchQuery) }
                        }
                        
                        switch filter {
                        case .byName:
                            recipes.sort { $0.title < $1.title }
                        case .byDateAdded:
                            recipes.sort { $0.dateAdded < $1.dateAdded }
                        case .byType:
                            recipes.sort { $0.type < $1.type }
                        }
                        
                        promise(.success(recipes))
                    } catch let error {
                        print(error.localizedDescription)
                        promise(.success([]))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    promise(.success([]))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func add(recipe: Recipe, image: UIImage?) {
         
    }
    
    func remove(recipe: Recipe, completion: @escaping () -> Void) {
         
    }
    
    func update(recipe: Recipe, image: UIImage?) {
         
    }
}
