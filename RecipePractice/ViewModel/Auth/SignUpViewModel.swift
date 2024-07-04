//
//  SignUpViewModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI
import Combine

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    
    @ObservedObject var authService: AuthenticationService = .shared
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    private var cancellables = Set<AnyCancellable>()
    init() {
        setup()
    }
    private func setup() {
        authService.$isUserAuthenticated
            .sink { isAuthenticated in
                print("User authentication status: \(isAuthenticated)")
            }
            .store(in: &cancellables)
    }
    func signUp() {
        guard !emailAddress.isEmpty,!password.isEmpty else {
            print("No email address or password found.")
            return
        }
        Task {
            do {
                let returnedUserData = try await authService.createUser(email: emailAddress, password: password)
                print("Sign up successful")
                print(returnedUserData)
            } catch {
                print("Error during sign up: \(error)")
                print( "Failed to sign up. Please try again.")
                
            }
        }
    }
}
