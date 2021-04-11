//
//  AddPlanScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI
import PCLocale

struct AddPlanScreen: View {
    @EnvironmentObject
    private var navigator: Navigator
    @EnvironmentObject
    private var planModel: PlanModel

    @ObservedObject
    private var viewModel = ViewModel()

    var body: some View {
        VStack {
            HStack {
                InputLabel(text: .TITLE_INPUT_FIELD_LABEL)
                TextField(PCLocale.getLocalizableString(of: .TITLE_INPUT_FIELD_PLACEHOLDER), text: $viewModel.planTitle)
            }
            DateInputRow(date: $viewModel.planStartDate, label: .START_DATE_LABEL)
            DateInputRow(date: $viewModel.planEndDate, label: .END_DATE_LABEL)
            Text(localized: .NOTES)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            ScrollableTextView(text: $viewModel.planNotes)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.all, 24)
        .toolbar(content: {
            Button(action: onSave) {
                Text(localized: .SAVE)
            }
        })
        .alert(isPresented: $viewModel.showErrorAlert, content: {
            Alert(title: Text(viewModel.errorAlertMessage.title), message: Text(viewModel.errorAlertMessage.message))
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
        do {
            try planModel.setPlan(startDate: viewModel.planStartDate,
                                  endDate: viewModel.planEndDate,
                                  title: viewModel.planTitle,
                                  notes: viewModel.planNotes)
        } catch {
            print(error)
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
