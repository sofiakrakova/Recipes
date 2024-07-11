//
//  RootView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                NetworkRecipesView()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Рецепты")
                    }
                RecipesView()
                    .tabItem {
                        Image(systemName: "fork.knife")
                        Text("Сохранённые")
                    }
            }
            .onAppear {
                viewModel.checkUserAuthentication()
            }
            .fullScreenCover(isPresented: $viewModel.showSignInView) {
                NavigationStack {
                    SignUpEmailView()
                }
            }
        }
    }
}

#Preview {
    RootView()
}
