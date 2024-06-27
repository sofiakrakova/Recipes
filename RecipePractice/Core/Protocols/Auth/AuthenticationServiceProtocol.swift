//
//  AuthenticationServiceProtocol.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import Foundation

protocol AuthenticationServiceProtocol {
    static var shared: AuthenticationService { get }
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func signIn(email: String, password: String) async throws -> AuthDataResultModel
    func signOut() throws
}
