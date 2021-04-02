//
//  HomeScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI
import ShrimpExtensions

struct HomeScreen: View {
    @EnvironmentObject
    private var planModel: PlanModel

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
            return HomeScreenView(dates: planModel.currentDays,
                                  width: viewModel.viewWidth / (CGFloat(planModel.currentDays.count) - 1),
                                  previousDate: { planModel.incrementCurrentDays(by: -1) },
                                  goToTodayDate: planModel.setCurrentDaysToFromNow,
                                  nextDate: { planModel.incrementCurrentDays(by: 1) })
        }
    }
}

private struct HomeScreenView: View {
    let dates: [Date]
    let width: CGFloat
    let previousDate: () -> Void
    let goToTodayDate: () -> Void
    let nextDate: () -> Void

    var body: some View {
        VStack {
            ControlCenter(previousDate: previousDate, goToTodayDate: goToTodayDate, nextDate: nextDate)
                .padding(.vertical, 8)
            HStack(spacing: 0) {
                PlanColumn(date: dates.first ?? Date(), width: width, isShowing: false)
                    .padding(.leading, -width)
                ForEach(1..<dates.count - 1, id: \.self) { dateIndex in
                    PlanColumn(date: dates[dateIndex], width: width, isShowing: true)
                        .border(width: 1, edges: planColumnBorder(index: dateIndex), color: .appSecondary)
                }
                PlanColumn(date: dates.last ?? Date(), width: width, isShowing: false)
                    .padding(.trailing, -width)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func planColumnBorder(index: Int) -> [Edge] {
        if index != 1 {
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
        .environmentObject(PlanModel(amountOfDaysToDisplay: 5))
    }
}
