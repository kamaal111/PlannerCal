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
    @EnvironmentObject
    private var navigator: Navigator

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
                                  width: columnViewWidth,
                                  showSecondaryColumns: showSecondaryColumns,
                                  previousDate: { planModel.incrementCurrentDays(by: -1) },
                                  goToTodayDate: planModel.setCurrentDaysToFromNow,
                                  nextDate: { planModel.incrementCurrentDays(by: 1) },
                                  addPlanItem: { date in
                                    planModel.addPlanItem(date)
                                    navigator.navigate(to: .addNewPlan)
                                  })
        }
        .frame(minWidth: Constants.planColumnMinimumWidth * (currentDaysCount - (columnViewWidth > Constants.planColumnMinimumWidth ? 1 : 2)))
    }

    private var currentDaysCount: CGFloat {
        CGFloat(planModel.currentDays.count)
    }

    private var columnViewWidth: CGFloat {
        viewModel.viewWidth / (currentDaysCount - 1)
    }

    private var showSecondaryColumns: Bool {
        columnViewWidth > (Constants.planColumnMinimumWidth / currentDaysCount) * (currentDaysCount - 1)
    }
}

private struct HomeScreenView: View {
    let dates: [Date]
    let width: CGFloat
    let showSecondaryColumns: Bool
    let previousDate: () -> Void
    let goToTodayDate: () -> Void
    let nextDate: () -> Void
    let addPlanItem: (_ date: Date) -> Void

    var body: some View {
        VStack {
            ControlCenter(previousDate: previousDate, goToTodayDate: goToTodayDate, nextDate: nextDate)
                .padding(.vertical, 8)
            HStack(spacing: 0) {
                ZStack {
                    if showSecondaryColumns {
                        PlanColumn(date: dates.first ?? Date(), width: width, isShowing: false, addItem: addPlanItem)
                    }
                }
                .padding(.leading, showSecondaryColumns ? -width : 0)
                ForEach(1..<dates.count - 1, id: \.self) { dateIndex in
                    PlanColumn(date: dates[dateIndex], width: width, isShowing: true, addItem: addPlanItem)
                        .border(width: 1, edges: planColumnBorder(index: dateIndex), color: .appSecondary)
                }
                ZStack {
                    if showSecondaryColumns {
                        PlanColumn(date: dates.last ?? Date(), width: width, isShowing: false, addItem: addPlanItem)
                    }
                }
                .padding(.trailing, showSecondaryColumns ? -width : 0)
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
