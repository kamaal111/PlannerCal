//
//  PlanSelectionScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI

struct PlanSelectionScreen: View {
    @EnvironmentObject
    private var planModel: PlanModel

    var body: some View {
        Text(planModel.planToShow?.title ?? "")
    }
}

struct PlanSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        return PlanSelectionScreen()
            .environmentObject(PlanModel(amountOfDaysToDisplay: 5, preview: true))
    }
}
