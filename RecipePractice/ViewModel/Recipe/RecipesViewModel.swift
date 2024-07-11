//
//  RecipesViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 03.07.2024.
//

import Combine
import RealmSwift
import UIKit

class RecipesViewModel: ObservableObject {
    let service: RecipesServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var recipes: [Recipe] = []
    @Published var searchQuery: String = ""
    @Published var sort: RecipesSort = .byName
    @Published var isAddRecipeViewPresented = false
    
    init(service: RecipesServiceProtocol = RecipesService()) {
        self.service = service
        fetchRecipes()
    }
    
    func addRecipe(recipe: Recipe, image: UIImage?) {
        service.add(recipe: recipe, image: image)
        fetchRecipes()
    }
    
    func removeRecipe(recipe: Recipe) {
        service.remove(recipe: recipe) { [weak self] in
            self?.fetchRecipes()
        }
    }
    
    func updateRecipe(recipe: Recipe, image: UIImage?) {
        service.update(recipe: recipe, image: image)
        fetchRecipes()
    }
    
    func fetchRecipes() {
        Publishers.CombineLatest($searchQuery, $sort)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .flatMap { [weak self] searchQuery, sort -> AnyPublisher<[Recipe], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                return self.service.fetch(filter: sort, searchQuery: searchQuery)
            }
            .receive(on: RunLoop.main)
            .assign(to: &$recipes)
    }
}
