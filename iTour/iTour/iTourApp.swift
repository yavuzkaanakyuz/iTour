//
//  iTourApp.swift
//  iTour
//
//  Created by Yavuz Kaan Akyüz on 6.07.2024.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
