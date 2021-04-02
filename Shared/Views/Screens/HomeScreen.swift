//
//  HomeScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject
    private var viewModel = HomeScreen.ViewModel()

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
        GeometryReader { (geometry: GeometryProxy) -> HomeScreenView in
            viewModel.setViewWidth(with: geometry.size.width)
            return HomeScreenView(days: viewModel.days, width: viewModel.viewWidth / 4)
        }
        .padding(.top, 24)
    }
}

private struct HomeScreenView: View {
    let days: [String]
    let width: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            ForEach((0..<days.count), id: \.self) { dayIndex in
                PlanColumn(title: days[dayIndex], width: width)
                    .border(width: 1, edges: planColumnBorder(index: dayIndex), color: .appSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func planColumnBorder(index: Int) -> [Edge] {
        if index != 0 {
            return [.trailing]
        }
        return [.leading, .trailing]
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
