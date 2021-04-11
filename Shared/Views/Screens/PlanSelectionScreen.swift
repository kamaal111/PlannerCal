//
//  PlanSelectionScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI
import PCLocale

struct PlanSelectionScreen: View {
    @EnvironmentObject
    private var planModel: PlanModel

    @State private var editMode = false
    @State private var editedTitle = ""
    @State private var editedStartDate = Date()
    @State private var editedEndDate = Date()
    @State private var editedNotes = ""

    var body: some View {
        ZStack {
            if editMode {
                ModifyPlan(title: $editedTitle, startDate: $editedStartDate, endDate: $editedEndDate, notes: $editedNotes)
            } else {
                VStack {
                    PlanSelectionInfoRow(label: .TITLE_INPUT_FIELD_LABEL, value: planTitle)
                        .padding(.bottom, 8)
                    PlanSelectionInfoRow(label: .START_DATE_LABEL,
                                         value: Self.dateFormatter.string(from: planStartDate))
                        .padding(.bottom, 8)
                    PlanSelectionInfoRow(label: .END_DATE_LABEL,
                                         value: Self.dateFormatter.string(from: planEndDate))
                        .padding(.bottom, 8)
                    if let notes = planModel.planToShow?.notes {
                        PlanSelectionInfoRow(label: .NOTES, value: notes)
                            .padding(.bottom, 8)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .padding(.all, 24)
        .toolbar(content: {
            if editMode {
                Button(action: {
                    withAnimation { editMode = false }
                }) {
                    #warning("Localize this")
                    Text("Cancel")
                }
            }
            Button(action: {
                if editMode {
                    // Edit plan
                    withAnimation { editMode = false }
                } else {
                    editedTitle = planTitle
                    editedStartDate = planStartDate
                    editedEndDate = planEndDate
                    editedNotes = planModel.planToShow?.notes ?? ""
                    withAnimation { editMode = true }
                }
            }) {
                #warning("Localize this")
                Text(editMode ? "Save" : "Edit")
            }
        })
    }

    private var planTitle: String {
        planModel.planToShow?.title ?? ""
    }

    private var planStartDate: Date {
        planModel.planToShow?.startDate ?? Date()
    }

    private var planEndDate: Date {
        planModel.planToShow?.endDate ?? Date()
    }

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

struct PlanSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        let planModel = PlanModel(amountOfDaysToDisplay: 5, preview: true)
        planModel.showPlan(planModel.currentPlans.first(where: { $0.value.first != nil })?.value.first?.renderPlan)
        return PlanSelectionScreen()
            .environmentObject(planModel)
    }
}
