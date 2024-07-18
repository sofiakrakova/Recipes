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
    @Published var recipes: [Recipe] = []
    @Published var searchQuery: String = ""
    @Published var sort: RecipesSort = .byName
    @Published var searchType: SearchType = .byName
    @Published var isAddRecipeViewPresented = false
    
    private let interactor: RecipesInteractorProtocol
    private let authService: AuthenticationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: RecipesInteractorProtocol, authService: AuthenticationServiceProtocol) {
        self.interactor = interactor
        self.authService = authService
    }
    
    func addRecipe(recipe: Recipe, image: UIImage?) {
        interactor.add(recipe: recipe, image: image)
        fetchRecipes()
    }
    
    func removeRecipe(recipe: Recipe) {
        interactor.remove(recipe: recipe) { [weak self] in
            self?.fetchRecipes()
        }
    }
    
    func updateRecipe(recipe: Recipe, image: UIImage?) {
        interactor.update(recipe: recipe, image: image)
        fetchRecipes()
    }
    
    func fetchRecipes() {
        Publishers.CombineLatest3($searchQuery, $sort, $searchType)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .flatMap { [weak self] searchQuery, sort, searchType -> AnyPublisher<[Recipe], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                return self.interactor.fetch(filter: sort, searchQuery: searchQuery.isEmpty ? nil : searchQuery, searchType: searchType)
            }
            .receive(on: RunLoop.main)
            .assign(to: &$recipes)
    }
    
    func signOut() {
        try? authService.signOut()
    }
    
    var isLocal: Bool {
        interactor is LocalRecipesInteractor
    }
}
