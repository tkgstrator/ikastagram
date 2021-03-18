//
//  ikastagramApp.swift
//  ikastagram
//
//  Created by Devonly on 3/17/21.
//

import SwiftUI
import Firebase

@main
struct ikastagramApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MessageViewModel())
                .sheet(isPresented: $isFirstLaunch) {
                    FirebaseUIView()
                }
        }
    }
}
