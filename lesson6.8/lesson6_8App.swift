//
//  lesson6_8App.swift
//  lesson6.8
//
//  Created by Javlonbek on 05/02/22.
//

import SwiftUI
import Firebase

@main
struct lesson6_8App: App {
    @StateObject var session = SessionStore()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            StarterScreen()
                .environmentObject(session)
        }
    }
}
