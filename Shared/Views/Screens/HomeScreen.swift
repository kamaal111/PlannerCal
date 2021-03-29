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
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Sun"
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
        HStack(spacing: 8) {
            ForEach((0..<days.count), id: \.self) { dayIndex in
                PlanColumn(title: days[dayIndex], isLast: dayIndex >= days.count - 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.all, 24)
    }
}

struct PlanColumn: View {
    let title: String
    let isLast: Bool

    var body: some View {
        VStack {
            Text(title)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.trailing, 8)
        .border(width: 1, edges: !isLast ? [.trailing] : [], color: Color(NSColor.separatorColor))
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
