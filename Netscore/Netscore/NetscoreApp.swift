//
//  NetscoreApp.swift
//  Netscore
//
//  Created by Yousuf Yesil on 16.12.22.
//

import SwiftUI
import Firebase


@main
struct NetscoreApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

