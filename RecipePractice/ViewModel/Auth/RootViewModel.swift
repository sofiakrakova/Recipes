//
//  RootViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//
//
import SwiftUI
import Combine

@MainActor
final class RootViewModel: ObservableObject {
    @Published var showSignInView: Bool = false
    var authService: AuthenticationService = .shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setup()
        checkUserAuthentication()
    }
    
    private func setup() {
        authService.$isUserAuthenticated
            .sink { [weak self] isAuthenticated in
                print("User authentication status: \(isAuthenticated)")
                self?.showSignInView = !isAuthenticated
            }
            .store(in: &cancellables)
    }
    
    func checkUserAuthentication() {
        do {
            let _ = try authService.getAuthenticatedUser()
            // Если аутентификация успешна, скрываем экран входа
            showSignInView = false
        } catch {
            // Если ошибка, показываем экран входа
            showSignInView = true
        }
    }
}

