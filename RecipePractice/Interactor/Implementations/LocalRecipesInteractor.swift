//
//  LocalRecipesInteractor.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 18.07.2024.
//

import Foundation
import Combine
import UIKit

class LocalRecipesInteractor: RecipesInteractorProtocol {
    private let service: RecipesServiceProtocol
    
    init(service: RecipesServiceProtocol) {
        self.service = service
    }
    
    func fetch(filter: RecipesSort, searchQuery: String?, searchType: SearchType) -> AnyPublisher<[Recipe], Never> {
        return service.fetch(filter: filter, searchQuery: searchQuery, searchType: searchType)
    }
    
    func add(recipe: Recipe, image: UIImage?) {
        service.add(recipe: recipe, image: image)
    }
    
    func remove(recipe: Recipe, completion: @escaping () -> Void) {
        service.remove(recipe: recipe, completion: completion)
    }
    
    func update(recipe: Recipe, image: UIImage?) {
        service.update(recipe: recipe, image: image)
    }
}
