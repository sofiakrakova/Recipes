//
//  RecipePracticeApp.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Swinject

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct RecipePracticeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let container = AppContainer.shared.container
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                let viewModel = container.resolve(RootViewModel.self)!
                RootView(viewModel: viewModel)
                    .environment(\.container, container)
            }
        }
    }
}
