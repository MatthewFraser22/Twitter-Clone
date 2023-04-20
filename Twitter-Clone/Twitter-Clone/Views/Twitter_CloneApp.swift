//
//  Twitter_CloneApp.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-02.
//

import SwiftUI

@main
struct Twitter_CloneApp: App {
    @StateObject var authViewModel: AuthViewModel = AuthViewModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
