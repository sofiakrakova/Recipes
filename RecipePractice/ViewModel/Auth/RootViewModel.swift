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
    var authService: AuthenticationService = AuthenticationService.shared
    
    init() {
        authService.onAuthChange = { isAuth in
            self.showSignInView = !isAuth
        }
        checkUserAuthentication()
    }
    
    func checkUserAuthentication() {
        do {
            try authService.getAuthenticatedUser()
            // Если аутентификация успешна, скрываем экран входа
            showSignInView = false
        } catch {
            // Если ошибка, показываем экран входа
            showSignInView = true
        }
    }
}

