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
            NavigationStack {
                ContentView()
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

#Preview {
    RootView()
}
