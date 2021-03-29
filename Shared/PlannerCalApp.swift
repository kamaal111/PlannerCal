//
//  PlannerCalApp.swift
//  Shared
//
//  Created by Kamaal M Farah on 21/03/2021.
//

import SwiftUI

@main
struct PlannerCalApp: App {
    @StateObject private var navigator = Navigator()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container!.viewContext)
                .environmentObject(navigator)
        }
    }
}
