//
//  RootViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//
//
import SwiftUI
import Combine

final class RootViewModel: ObservableObject {
    @Published var showSignInView: Bool = false
    var authService: AuthenticationServiceProtocol
    
    init(service: AuthenticationServiceProtocol) {
        authService = service
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

