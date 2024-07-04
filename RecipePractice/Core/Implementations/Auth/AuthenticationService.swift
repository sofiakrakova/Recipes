//
//  AuthenticationService.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift

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
        isUserAuthenticated = false
    }
    
    func signInWithGoogle() async throws -> AuthDataResultModel {
        guard let rootViewController = await UIApplication.shared.firstKeyWindow?.rootViewController else {
            throw NSError(domain: "AuthenticationService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to get root view controller"])
        }
        guard let clientID = FirebaseApp.app()?.options.clientID
        else {
            throw NSError(domain: "AuthenticationService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to get Firebase client ID"])
        }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(domain: "AuthenticationService", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to get ID token"])
        }
        let accessToken = result.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        let authResult = try await Auth.auth().signIn(with: credential)
        isUserAuthenticated = true
        return AuthDataResultModel(user: authResult.user)
    }
}
extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive}
            .first?.windows
            .first(where: \.isKeyWindow)
    }
}
