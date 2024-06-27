//
//  AuthenticationService.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

final class AuthenticationService: AuthenticationServiceProtocol, ObservableObject {
    static var shared = AuthenticationService()
    @Published var isUserAuthenticated: Bool = false
    
    init() {}
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        isUserAuthenticated = true
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
