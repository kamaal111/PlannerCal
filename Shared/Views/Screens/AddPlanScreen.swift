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
    private var planModel: PlanModel

    @State private var planTitle = ""
    @State private var planNotes = ""

    var body: some View {
        VStack {
            HStack {
                InputLabel(localizedKey: .TITLE_INPUT_FIELD_LABEL)
                TextField(PCLocale.getLocalizableString(of: .TITLE_INPUT_FIELD_PLACEHOLDER), text: $planTitle)
            }
            HStack {
                InputLabel(localizedKey: .DATE_LABEL)
                DatePicker("", selection: $planModel.planToAddDate, displayedComponents: .date)
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
