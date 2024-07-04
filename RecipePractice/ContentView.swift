//
//  ContentView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 27.06.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            RecipesView()
            Button("Sign out"){
                try? AuthenticationService.shared.signOut()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
