//
//  HomeScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI
import ShrimpExtensions
import PCLocale

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
            .navigationTitle(PCLocale.Keys.APP_TITLE.localized)
        #else
        view()
            .navigationBarTitle(Text(localized: .APP_TITLE), displayMode: .large)
        #endif
    }

    private func view() -> some View {
        GeometryReader { (geometry: GeometryProxy) -> HomeScreenView in
            viewModel.setViewWidth(with: geometry.size.width)
            return HomeScreenView(dates: planModel.currentDays,
                                  plans: planModel.currentPlans,
                                  unfinishedPlans: planModel.unfinishedPlans,
                                  width: columnViewWidth,
                                  showSecondaryColumns: showSecondaryColumns,
                                  previousDate: { planModel.incrementCurrentDays(by: -1) },
                                  goToTodayDate: planModel.setCurrentDaysToFromNow,
                                  nextDate: { planModel.incrementCurrentDays(by: 1) },
                                  addPlanItem: { date in
                                    navigator.navigate(to: .addNewPlan, options: ["date": date])
                                  },
                                  onPlanPress: { plan in
                                    planModel.showPlan(plan)
                                    navigator.setSelection(to: .plan)
                                  })
        }
        .frame(minWidth: screenMinimumWidth)
    }

    private var currentDaysCount: CGFloat {
        CGFloat(planModel.currentDays.count)
    }

    private var screenMinimumWidth: CGFloat {
        let columnViewIsWiderThanPlanColumn = columnViewWidth > Constants.planColumnMinimumWidth
        return Constants.planColumnMinimumWidth * (currentDaysCount - (columnViewIsWiderThanPlanColumn ? 1 : 2))
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
    let plans: [Date: [CorePlan]]
    let unfinishedPlans: [CorePlan]
    let width: CGFloat
    let showSecondaryColumns: Bool
    let previousDate: () -> Void
    let goToTodayDate: () -> Void
    let nextDate: () -> Void
    let addPlanItem: (_ date: Date) -> Void
    let onPlanPress: (_ plan: CorePlan.RenderPlan) -> Void

    var body: some View {
        VStack {
            ControlCenter(previousDate: previousDate, goToTodayDate: goToTodayDate, nextDate: nextDate)
                .padding(.vertical, 8)
            HStack(spacing: 0) {
                ZStack {
                    if showSecondaryColumns, let firstDate = dates.first {
                        PlanColumn(date: firstDate,
                                   plans: renderPlans(forDate: firstDate),
                                   width: width,
                                   isPrimary: false,
                                   addItem: addPlanItem,
                                   onPlanPress: { _ in })
                    }
                }
                .padding(.leading, showSecondaryColumns ? -width : 0)
                ForEach(1..<dates.count - 1, id: \.self) { dateIndex in
                    PlanColumn(date: dates[dateIndex],
                               plans: renderPlans(forDate: dates[dateIndex]),
                               width: width,
                               isPrimary: true,
                               addItem: addPlanItem,
                               onPlanPress: onPlanPress)
                        .border(width: 1, edges: planColumnBorder(index: dateIndex), color: .appSecondary)
                }
                ZStack {
                    if showSecondaryColumns, let lastDate = dates.last {
                        PlanColumn(date: lastDate,
                                   plans: renderPlans(forDate: lastDate),
                                   width: width,
                                   isPrimary: false,
                                   addItem: addPlanItem,
                                   onPlanPress: { _ in })
                    }
                }
                .padding(.trailing, showSecondaryColumns ? -width : 0)
            }
            HStack {
                GeneralPlanColumn(plans: unfinishedPlans.map(\.renderPlan), type: .unfinished, onPlanPress: onPlanPress)
                    .border(width: 1, edges: [.trailing], color: .appSecondary)
                GeneralPlanColumn(plans: [], type: .general, onPlanPress: onPlanPress)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func renderPlans(forDate date: Date?) -> [CorePlan.RenderPlan] {
        guard let date = date, let datePlans = plans[date] else { return [] }
        return datePlans.map(\.renderPlan)
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
        .environmentObject(PlanModel(amountOfDaysToDisplay: 5, preview: true))
    }
}
