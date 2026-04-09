//
//  A2_iOS_Woohyuk_Harry__101524575App.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import SwiftUI

@main
struct A2_iOS_Woohyuk_Harry__101524575App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
