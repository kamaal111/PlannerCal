//
//  HomeScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        #if os(macOS)
        view()
            .navigationTitle("PlannerCal")
        #else
        view()
            .navigationBarTitle(Text("PlannerCal"), displayMode: .large)
        #endif
    }

    private func view() -> some View {
        Text("Hello, World!")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
