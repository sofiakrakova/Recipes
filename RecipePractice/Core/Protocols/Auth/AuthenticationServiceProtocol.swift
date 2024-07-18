//
//  AuthenticationServiceProtocol.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import Foundation

protocol AuthenticationServiceProtocol {
    @discardableResult
    func getAuthenticatedUser() throws -> AuthDataResultModel
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel
    @discardableResult
    func signInWithGoogle() async throws -> AuthDataResultModel
    func signOut() throws
    func isUserAuthenticated() -> Bool
    
    var onAuthChange: ((Bool) -> Void)? { get set }
}
