//
//  SelectionScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI
import PCLocale

struct SelectionScreen: View {
    @EnvironmentObject
    private var navigator: Navigator

    var body: some View {
        ZStack {
            if navigator.selectionView == .some(.plan) {
                PlanSelectionScreen()
            } else {
                Text(localized: .NO_SELECTION)
                    .font(.headline)
            }
        }
        .frame(minWidth: 200)
    }
}

struct SelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        let navigator = Navigator()
        return SelectionScreen()
            .environmentObject(navigator)
            .environmentObject(PlanModel(amountOfDaysToDisplay: 5, preview: true))
    }
}
