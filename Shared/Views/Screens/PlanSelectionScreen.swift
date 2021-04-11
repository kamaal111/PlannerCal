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

    var body: some View {
        VStack {
            PlanSelectionInfoRow(label: .TITLE_INPUT_FIELD_LABEL, value: planModel.planToShow?.title ?? "")
                .padding(.bottom, 8)
            PlanSelectionInfoRow(label: .START_DATE_LABEL,
                                 value: Self.dateFormatter.string(from: planModel.planToShow?.startDate ?? Date()))
                .padding(.bottom, 8)
            PlanSelectionInfoRow(label: .END_DATE_LABEL,
                                 value: Self.dateFormatter.string(from: planModel.planToShow?.endDate ?? Date()))
                .padding(.bottom, 8)
            if let notes = planModel.planToShow?.notes {
                PlanSelectionInfoRow(label: .NOTES, value: notes)
                    .padding(.bottom, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.all, 16)
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
