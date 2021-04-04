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

    @State private var tabSelection = 0

    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationView {
                ZStack {
                    NavigationLink(destination: HomeScreen(),
                                   tag: Navigator.ScreenSelection.home.rawValue,
                                   selection: $navigator.screenSelection) {
                        EmptyView()
                    }
                    NavigationLink(destination: AddPlanScreen(),
                                   tag: Navigator.ScreenSelection.addNewPlan.rawValue,
                                   selection: $navigator.screenSelection) {
                        EmptyView()
                    }
                    HomeScreen()
                }
            }
            .tabItem({
                Image(systemName: "house.fill")
                Text("Home")
            })
            .tag(0)
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
