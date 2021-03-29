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
        List {
            Section(header: Text("Screens")) {
                NavigationLink(destination: HomeScreen(),
                               tag: Navigator.SidebarSelection.home.rawValue,
                               selection: $navigator.sidebarSelection) {
                    Label("Home", systemImage: "house.fill")
                }
            }
        }
        .toolbar {
            Button(action: toggleSidebar) {
                Label("Toggle Sidebar", systemImage: "sidebar.left")
            }
        }
    }

    private func toggleSidebar() {
        guard let firstResponder = NSApp.keyWindow?.firstResponder else { return }
        firstResponder.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct AppSidebar_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebar()
    }
}
