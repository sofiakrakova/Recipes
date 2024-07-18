//
//  RootView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI
import Swinject

struct RootView: View {
    @Environment(\.container) var container: Container
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        ZStack {
            TabView {
                RecipesView(viewModel: self.container.resolve(RecipesViewModel.self, name: "APIViewModel")!)
                .tabItem {
                    Image(systemName: "globe")
                    Text(StringCatalog.recipies)
                }
                RecipesView(viewModel: self.container.resolve(RecipesViewModel.self, name: "LocalViewModel")!)
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text(StringCatalog.saved)
                }
            }
            .onAppear {
                viewModel.checkUserAuthentication()
            }
            .fullScreenCover(isPresented: $viewModel.showSignInView) {
                NavigationStack {
                    SignUpEmailView(viewModel: container.resolve(SignUpEmailViewModel.self)!)
                }
            }
        }
    }
}
