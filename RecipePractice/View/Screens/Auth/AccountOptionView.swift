//
//  AccountOptionView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI
import Swinject

struct AccountOptionView: View {
    @Environment(\.container) var container: Container
    
    var body: some View {
        HStack(spacing: 16) {
            Text("Already have an account?")
                .font(.system(.body, design:.rounded))
                .bold()
                .foregroundColor(.blue)
            NavigationLink(destination: SignInEmailView(viewModel: container.resolve(SignInEmailViewModel.self)!)) {
                Text("Sign in")
                    .foregroundColor(.blue)
            }
        }
        .padding(.bottom, 24)
    }
}
