//
//  AppTabView.swift
//  PlannerCal (iOS)
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

struct AppTabView: View {
    @EnvironmentObject
    private var navigator: Navigator

    var body: some View {
        TabView(selection: $navigator.screenSelection) {
            NavigationView {
                HomeScreen()
            }
            .tabItem({
                Image(systemName: "house.fill")
                Text("Home")
            })
            .tag(Navigator.ScreenSelection.home.rawValue)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(Navigator())
    }
}
