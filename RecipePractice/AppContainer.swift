import SwiftUI
import Swinject

extension EnvironmentValues {
    var container: Container {
        get { self[ContainerKey.self] }
        set {
            self[ContainerKey.self] = newValue
        }
    }
}

struct ContainerKey: EnvironmentKey {
    static let defaultValue: Container = AppContainer.shared.container
}

class AppContainer {
    static let shared = AppContainer()
    
    let container: Container
    
    init() {
        container = Container()
        setupDependencies()
    }
    
    private func setupDependencies() {
        // Register services
        container.register(APIRecipesServiceProtocol.self, name: "APIService") { _ in
            return RecipeAPIService()
        }
        
        container.register(RecipesServiceProtocol.self, name: "LocalService") { _ in
                    return RecipesService()
        }
        
        container.register(RecipesInteractorProtocol.self, name: "NetworkInteractor") { resolver in
            let service = resolver.resolve(APIRecipesServiceProtocol.self, name: "APIService")!
            return NetworkRecipesInteractor(service: service)
        }
        
        container.register(RecipesInteractorProtocol.self, name: "LocalInteractor") { resolver in
            let service = resolver.resolve(RecipesServiceProtocol.self, name: "LocalService")!
            return LocalRecipesInteractor(service: service)
        }
        
        container.register(AuthenticationServiceProtocol.self) { resolver in
            return AuthenticationService()
        }
        
        // Register ViewModels
        container.register(RecipesViewModel.self, name: "APIViewModel") { resolver in
            let interactor = resolver.resolve(RecipesInteractorProtocol.self, name: "NetworkInteractor")!
            let service = resolver.resolve(AuthenticationServiceProtocol.self)!
            return RecipesViewModel(interactor: interactor, authService: service)
        }
        
        container.register(RecipesViewModel.self, name: "LocalViewModel") { resolver in
            let interactor = resolver.resolve(RecipesInteractorProtocol.self, name: "LocalInteractor")!
            let service = resolver.resolve(AuthenticationServiceProtocol.self)!
            return RecipesViewModel(interactor: interactor, authService: service)
        }
        
        container.register(RootViewModel.self) { resolver in
            let service = resolver.resolve(AuthenticationServiceProtocol.self)!
            return RootViewModel(service: service)
        }
        
        container.register(SignInEmailViewModel.self) { resolver in
            let service = resolver.resolve(AuthenticationServiceProtocol.self)!
            return SignInEmailViewModel(authService: service)
        }
        
        container.register(SignUpEmailViewModel.self) { resolver in
            let service = resolver.resolve(AuthenticationServiceProtocol.self)!
            return SignUpEmailViewModel(authService: service)
        }
        
        container.register(AddRecipeViewModel.self) { resolver in
            let interactor = resolver.resolve(RecipesInteractorProtocol.self, name: "LocalInteractor")!
            return AddRecipeViewModel(interactor: interactor)
        }
        
        container.register(EditRecipeViewModel.self) { resolver in
                    let interactor = resolver.resolve(RecipesInteractorProtocol.self, name: "LocalInteractor")!
                    return EditRecipeViewModel(interactor: interactor)
                }
        
        container.register(RecipeDetailViewModel.self) { resolver in
                    let interactor = resolver.resolve(RecipesInteractorProtocol.self, name: "LocalInteractor")!
                    return RecipeDetailViewModel(interactor: interactor)
                }
    }
}
