//
//  AuthDataResultModel.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 26.06.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
