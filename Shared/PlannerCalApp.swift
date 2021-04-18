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
    @StateObject private var planModel = PlanModel(amountOfDaysToDisplay: 5)
    @StateObject private var userData = UserData()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container!.viewContext)
                .environmentObject(navigator)
                .environmentObject(deviceModel)
                .environmentObject(planModel)
                .environmentObject(userData)
        }
    }
}
