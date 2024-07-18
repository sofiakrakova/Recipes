//
//  NetworkRecipesInteractor.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 18.07.2024.
//

import Foundation
import UIKit
import Combine

class NetworkRecipesInteractor: RecipesInteractorProtocol {
    private let service: APIRecipesServiceProtocol
    
    init(service: APIRecipesServiceProtocol) {
        self.service = service
    }
    
    func fetch(filter: RecipesSort, searchQuery: String?, searchType: SearchType) -> AnyPublisher<[Recipe], Never> {
        return service.fetch(filter: filter, searchQuery: searchQuery, searchType: searchType)
    }
    
    func add(recipe: Recipe, image: UIImage?) {
        
    }
    
    func remove(recipe: Recipe, completion: @escaping () -> Void) {
        
    }
    
    func update(recipe: Recipe, image: UIImage?) {
    }
}
