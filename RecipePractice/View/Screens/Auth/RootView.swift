//
//  RootView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack {
            NavigationStack{
                ContentView()
            }
            .onAppear{
                let authUser = try? 
                    AuthenticationService.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }
            .fullScreenCover(isPresented: $showSignInView) {
                NavigationStack {
                    SignUpEmailView()
                }
            }
           // .environmentObject(AuthenticationService.shared.$isUserAuthenticated)
        }
    }
}

#Preview {
    RootView()
}
