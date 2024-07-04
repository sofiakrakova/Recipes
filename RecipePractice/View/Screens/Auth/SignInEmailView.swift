//
//  SignInEmailView.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    var body: some View {
        VStack(spacing: 20) {
            FormFieldView(fieldName: "Email", fieldValue: $viewModel.emailAddress)
            FormFieldView(fieldName: "Password", fieldValue: $viewModel.emailPassword, isSecure: true)
            Spacer()
            Button(action: {
                viewModel.signIn()
            }, label: {
                Text("Sign In with Email")
            })
            .buttonStyle(BlueGradientButtonStyle())
            Button(action: {
                viewModel.signInWithGoogle()
            }, label: {
                Text("Sign In with Google")
            })
            .buttonStyle(BlueGradientButtonStyle())
        }
        .navigationTitle("Sign In")
        .padding(.vertical)
    }
}

#Preview {
    NavigationStack {
        SignInEmailView()
    }
}
