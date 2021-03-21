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
            List {
                Text("Hi")
            }
            List {
                Text("Hi")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar) {
                    Image(systemName: "sidebar.left")
                }
            }
        }
        .toolbar {

            ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                Button(action: { }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
#endif

#if os(iOS)
struct ContentViewiOS: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hi")
            }
            .navigationBarTitle(Text("PlannerCal"))
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: { }) {
                                    Image(systemName: "plus")
                                })
        }
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
