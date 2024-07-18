//
//  SignUpEmailView.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI

struct SignUpEmailView: View {
    @ObservedObject var viewModel: SignUpEmailViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                Text("Create an account")
                    .modifier(TitleModifier())
                    .padding(.top,16)
                VStack(alignment: .leading, spacing: 16)
                {
                    FormFieldView(fieldName: "Email", fieldValue: $viewModel.emailAddress)
                    RequirementTextView(text: "A minimum of 8 characters, with validation by shablon")
                        .padding(.horizontal, 10)
                }
                VStack(alignment: .leading, spacing: 16) {
                    FormFieldView(fieldName: "Password", fieldValue: $viewModel.password, isSecure: true)
                    
                    RequirementTextView(iconName: "lock.open", text: "A minimum of 8 characters, One uppercase letter", isStrikeThrough: false)
                        .padding(.horizontal, 10)
                }
                Spacer()
                VStack {
                    Button("Sign Up") {
                        viewModel.signUp()
                    }
                    .buttonStyle(BlueGradientButtonStyle())
                    AccountOptionView()
                }
                .padding(.bottom, 24)
            }
        }
    }
}
