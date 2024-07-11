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

protocol RecipesServiceProtocol {
    func fetch(filter: RecipesSort, searchQuery: String?) -> AnyPublisher<[Recipe], Never>
    func add(recipe: Recipe, image: UIImage?)
    func remove(recipe: Recipe, completion: @escaping () -> Void)
    func update(recipe: Recipe, image: UIImage?)
}
