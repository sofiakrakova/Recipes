//
//  AccountOptionView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI

struct AccountOptionView: View {
    var body: some View {
        HStack(spacing: 16) {
            Text("Already have an account?")
                .font(.system(.body, design:.rounded))
                .bold()
                .foregroundColor(.blue)
            NavigationLink(destination: SignInEmailView()) {
                Text("Sign in")
                    .foregroundColor(.blue)
            }
        }
        .padding(.bottom, 24)
    }
}

#Preview {
    AccountOptionView()
}
