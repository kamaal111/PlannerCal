//
//  SelectionScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI

struct SelectionScreen: View {
    @EnvironmentObject
    private var navigator: Navigator
    @EnvironmentObject
    private var planModel: PlanModel

    var body: some View {
        ZStack {
            if navigator.selectionView == .some(.plan) {
                Text(planModel.planToShow?.title ?? "")
            } else {
                #warning("Localize this")
                Text("No selection")
                    .font(.headline)
            }
        }
    }
}

struct SelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectionScreen()
            .environmentObject(Navigator())
            .environmentObject(PlanModel(amountOfDaysToDisplay: 5))
    }
}
