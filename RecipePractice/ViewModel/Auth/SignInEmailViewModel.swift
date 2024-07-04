//
//  SignInEmailViewModel.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//
import SwiftUI
import Combine

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var isSigningInWithGoogle: Bool = false
    var authService: AuthenticationService = .shared
    @Published var emailAddress: String = ""
    @Published var emailPassword: String = ""
    
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
