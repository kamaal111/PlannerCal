//
//  PlannerCalApp.swift
//  Shared
//
//  Created by Kamaal M Farah on 21/03/2021.
//

import SwiftUI

@main
struct PlannerCalApp: App {
    #if canImport(AppKit)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #elseif canImport(UIKit)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif

    @StateObject private var navigator = Navigator()
    @StateObject private var deviceModel = DeviceModel()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container!.viewContext)
                .environmentObject(navigator)
                .environmentObject(deviceModel)
        }
    }
}

#if canImport(AppKit)
final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let app = notification.object as? NSApplication {
            print(app)
        }
    }
}
#elseif canImport(UIKit)
final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(application)
        return true
    }
}
#endif
