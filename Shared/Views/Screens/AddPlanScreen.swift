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

    @State private var planTitle = ""
    @State private var planNotes = ""
    @State private var planDate = Date()

    var body: some View {
        VStack {
            HStack {
                InputLabel(localizedKey: .TITLE_INPUT_FIELD_LABEL)
                TextField(PCLocale.getLocalizableString(of: .TITLE_INPUT_FIELD_PLACEHOLDER), text: $planTitle)
            }
            HStack {
                InputLabel(localizedKey: .DATE_LABEL)
                DatePicker("", selection: $planDate, displayedComponents: .date)
                    .labelsHidden()
                Spacer()
            }
            Text(localized: .NOTES)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            ScrollableTextView(text: $planNotes)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.all, 24)
        .toolbar(content: {
            Button(action: {
                navigator.navigate(to: .home)
            }) {
                /// - TODO: Localize this
                Text("Save")
            }
        })
        .onAppear(perform: onNavigatorAppear)
    }

    private func onNavigatorAppear() {
        DispatchQueue.main.async {
            if let date =  navigator.screenOptions["date"] as? Date {
                planDate = date
            } else {
                if planModel.currentDays.count > 1 {
                    planDate = planModel.currentDays[1]
                }
            }
        }
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
        .environmentObject(PlanModel(amountOfDaysToDisplay: 5))
    }
}
