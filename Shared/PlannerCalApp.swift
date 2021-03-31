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
    @StateObject private var deviceModel = DeviceModel()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry -> ContentView in
                if deviceModel.screenSize != geometry.size {
                    deviceModel.screenSize = geometry.size
                }
                return ContentView()
            }
            .environment(\.managedObjectContext, persistenceController.container!.viewContext)
            .environmentObject(navigator)
            .environmentObject(deviceModel)
        }
    }
}
