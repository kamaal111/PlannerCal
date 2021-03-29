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
