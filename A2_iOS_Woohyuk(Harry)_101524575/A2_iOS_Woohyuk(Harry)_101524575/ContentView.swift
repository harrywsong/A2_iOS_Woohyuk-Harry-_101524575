//
//  ContentView.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Text("temp")
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
