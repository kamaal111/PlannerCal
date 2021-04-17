//
//  AddPlanScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI
import PCLocale
import ConsoleSwift

struct AddPlanScreen: View {
    @EnvironmentObject
    private var navigator: Navigator
    @EnvironmentObject
    private var planModel: PlanModel

    @ObservedObject
    private var viewModel = ViewModel()

    var body: some View {
        ModifyPlan(title: $viewModel.planTitle,
                   startDate: $viewModel.planStartDate,
                   endDate: $viewModel.planEndDate,
                   notes: $viewModel.planNotes)
            .padding(.all, 24)
            .toolbar(content: {
                Button(action: onSave) {
                    Text(localized: .SAVE)
                }
            })
            .alert(isPresented: $viewModel.showErrorAlert, content: {
                Alert(title: Text(viewModel.errorAlertMessage.title),
                      message: Text(viewModel.errorAlertMessage.message))
            })
            .onAppear(perform: onScreenAppear)
    }

    private func onScreenAppear() {
        DispatchQueue.main.async {
            if let date =  navigator.screenOptions["date"] as? Date {
                viewModel.planStartDate = date
                viewModel.planEndDate = date
            } else {
                if planModel.currentDays.count > 1 {
                    let date = planModel.currentDays[1]
                    viewModel.planStartDate = date
                    viewModel.planEndDate = date
                }
            }
        }
    }

    private func onSave() {
        guard viewModel.planValidation() else { return }
        var notes: String?
        if !viewModel.planNotes.trimmingByWhitespacesAndNewLines.isEmpty {
            notes = viewModel.planNotes
        }
        #warning("Put this in view model")
        let args = CorePlan.Args(startDate: viewModel.planStartDate,
                                 endDate: viewModel.planEndDate,
                                 title: viewModel.planTitle,
                                 notes: notes)
        do {
            try planModel.setPlan(with: args)
        } catch {
            console.error(Date(), error.localizedDescription, error)
            return
        }
        navigator.navigate(to: .home)
    }
}

struct AddPlanScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppSidebar()
            AddPlanScreen()
        }
        .environmentObject(Navigator())
        .environmentObject(DeviceModel())
        .environmentObject(PlanModel(amountOfDaysToDisplay: 5, preview: true))
    }
}
