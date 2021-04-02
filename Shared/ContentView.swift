//
//  ContentView.swift
//  Shared
//
//  Created by Kamaal M Farah on 21/03/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        #if os(macOS)
        ContentViewMacOS()
        #else
        ContentViewiOS()
        #endif
    }
}

#if os(macOS)
struct ContentViewMacOS: View {
    var body: some View {
        NavigationView {
            AppSidebar()
            HomeScreen()
        }
    }
}
#endif

#if os(iOS)
struct ContentViewiOS: View {
    var body: some View {
        ZStack {
            if UIDevice.current.isIpad {
                NavigationView {
                    AppSidebar()
                    HomeScreen()
                }
            } else {
                AppTabView()
            }
        }
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.context!)
            .environmentObject(DeviceModel())
            .environmentObject(Navigator())
            .environmentObject(PlanModel())
    }
}
