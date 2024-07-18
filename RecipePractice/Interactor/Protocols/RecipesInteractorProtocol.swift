//
//  RecipesInteractor.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 18.07.2024.
//

import Foundation
import UIKit
import Combine

protocol RecipesInteractorProtocol {
    func fetch(filter: RecipesSort, searchQuery: String?, searchType: SearchType) -> AnyPublisher<[Recipe], Never>
    func add(recipe: Recipe, image: UIImage?)
    func remove(recipe: Recipe, completion: @escaping () -> Void)
    func update(recipe: Recipe, image: UIImage?)
}
