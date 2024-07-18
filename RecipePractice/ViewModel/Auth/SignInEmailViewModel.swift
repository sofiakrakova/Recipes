//
//  SignInEmailViewModel.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//
import SwiftUI
import Combine

final class SignInEmailViewModel: ObservableObject {
    
    @Published var isSigningInWithGoogle: Bool = false
    private let authService: AuthenticationServiceProtocol
    @Published var emailAddress: String = ""
    @Published var emailPassword: String = ""
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    func signIn() {
        guard !emailAddress.isEmpty, !emailPassword.isEmpty else {
            print("No email address or password found.")
            return
        }
        Task {
            do {
                try await authService.signIn(email: emailAddress, password: emailPassword)
                print("Success")
            } catch {
                print("Error: \(error)")
            }
        }
    }
    func signInWithGoogle() {
        Task {
            do {
                try await authService.signInWithGoogle()
                print("Success")
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func signOut() {
        do {
            try authService.signOut()
            print("Signed out successfully")
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
