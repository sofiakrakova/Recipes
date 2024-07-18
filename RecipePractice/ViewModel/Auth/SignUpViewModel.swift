//
//  SignUpViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI

final class SignUpEmailViewModel: ObservableObject {
    
    private let authService: AuthenticationServiceProtocol
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }

    func signUp() {
        guard !emailAddress.isEmpty,!password.isEmpty else {
            print("No email address or password found.")
            return
        }
        Task {
            do {
                try await authService.createUser(email: emailAddress, password: password)
                print("Sign up successful")
            } catch {
                print("Error during sign up: \(error)")
            }
        }
    }
}
