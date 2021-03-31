//
//  HomeScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

struct HomeScreen: View {
    let days = [
        "Mon",
        "Tue",
        "Wed"
    ]

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
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 0) {
                ForEach((0..<days.count), id: \.self) { dayIndex in
                    PlanColumn(title: days[dayIndex])
                        .border(width: 1, edges: planColumnBorder(index: dayIndex), color: .appSecondary)
                }
            }
        }
        .frame(minWidth: 240, maxWidth: 240)
        .padding(.top, 24)
    }

    private func planColumnBorder(index: Int) -> [Edge] {
        if index == 0 {
            return [.leading, .trailing]
        }
        return [.trailing]
    }
}

struct PlanColumn: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
        }
        .frame(minWidth: 80, maxWidth: 80, maxHeight: .infinity, alignment: .top)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            #if os(macOS)
            AppSidebar()
            HomeScreen()
            #else
            if UIDevice.current.isIpad {
                AppSidebar()
            }
            HomeScreen()
            #endif
        }
        .environmentObject(Navigator())
    }
}
