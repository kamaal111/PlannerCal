//
//  AddGeneralItemScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 22/04/2021.
//

import SwiftUI

struct AddGeneralItemScreen: View {
    @EnvironmentObject
    private var navigator: Navigator
    @EnvironmentObject
    private var planModel: PlanModel

    @ObservedObject
    private var viewModel = ViewModel()

    var body: some View {
        ModifyPlan(title: $viewModel.title, notes: $viewModel.notes)
            .padding(24)
            .toolbar(content: {
                Button(action: onSave) {
                    Text(localized: .SAVE)
                }
            })
    }

    private func onSave() {
        print("save")
    }
}

struct AddGeneralItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppSidebar()
            AddGeneralItemScreen()
        }
        .environmentObject(Navigator())
        .environmentObject(PlanModel(amountOfDaysToDisplay: 5, preview: true))
    }
}
