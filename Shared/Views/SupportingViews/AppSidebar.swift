//
//  AppSidebar.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

struct AppSidebar: View {
    @EnvironmentObject
    private var navigator: Navigator

    var body: some View {
        #if os(macOS)
        view()
            .toolbar {
                Button(action: toggleSidebar) {
                    Label("Toggle Sidebar", systemImage: "sidebar.left")
                }
            }
        #else
        view()
        #endif
    }

    private func view() -> some View {
        List {
            Section(header: Text("Screens")) {
                NavigationLink(destination: HomeScreen(),
                               tag: Navigator.ScreenSelection.home.rawValue,
                               selection: $navigator.screenSelection) {
                    Label("Home", systemImage: "house.fill")
                }
                NavigationLink(destination: AddPlanScreen(),
                               tag: Navigator.ScreenSelection.addNewPlan.rawValue,
                               selection: $navigator.screenSelection) {
                    Label("Add a plan", systemImage: "calendar.badge.plus")
                }
            }
        }
    }

    #if os(macOS)
    private func toggleSidebar() {
        guard let firstResponder = NSApp.keyWindow?.firstResponder else { return }
        firstResponder.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    #endif
}

struct AppSidebar_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebar()
    }
}
