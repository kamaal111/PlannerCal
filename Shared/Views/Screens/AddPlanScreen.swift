//
//  AddPlanScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI
import SalmonUI

struct AddPlanScreen: View {
    @EnvironmentObject
    private var planModel: PlanModel

    @State private var planTitle = ""
    @State private var planNotes = ""

    var body: some View {
        VStack {
            HStack {
                InputLabel(text: "Title")
                TextField("Title of plan", text: $planTitle)
            }
            HStack {
                InputLabel(text: "Date")
                DatePicker("Date", selection: $planModel.planToAddDate, displayedComponents: .date)
                    .labelsHidden()
                Spacer()
            }
            Text("Notes")
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
