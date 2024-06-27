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
    }
    
    private func setup() {
        authService.$isUserAuthenticated
            .sink { isAuthenticated in
                print("User authentication status: \(isAuthenticated)")
            }
            .store(in: &cancellables)
    }
}
