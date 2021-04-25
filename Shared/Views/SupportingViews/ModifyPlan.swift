//
//  ModifyPlan.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 25/04/2021.
//

import SwiftUI

struct ModifyPlan: View {
    @Binding var title: String
    @Binding var notes: String

    var body: some View {
        VStack {
            TextInputRow(text: $title, label: .TITLE_INPUT_FIELD_LABEL, placeholder: .TITLE_INPUT_FIELD_PLACEHOLDER)
            LargeTextInputView(text: $notes, label: .NOTES)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ModifyPlan_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPlan(title: .constant("Titler"), notes: .constant("some notes"))
    }
}
