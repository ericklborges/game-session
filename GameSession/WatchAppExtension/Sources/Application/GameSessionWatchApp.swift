//
//  GameSessionWatchApp.swift
//  WatchAppExtension
//
//  Created by Erick Lozano Borges on 15/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI
import Database_watchOS

@main
struct GameSessionWatchApp: App {
    
    init() {
        CoreDataStore.shared.loadStore()
    }

    var body: some Scene {
        WindowGroup {
            CounterListView()
        }
    }
}
