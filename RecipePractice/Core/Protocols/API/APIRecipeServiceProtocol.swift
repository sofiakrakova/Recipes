//
//  APIRecipeServiceProtocol.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 18.07.2024.
//

import Foundation
import Combine

protocol APIRecipesServiceProtocol {
    func fetch(filter: RecipesSort, searchQuery: String?, searchType: SearchType) -> AnyPublisher<[Recipe], Never>
}
