//
//  ModifyPlan.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI
import PCLocale

struct ModifyPlan: View {
    @Binding var title: String
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var notes: String

    var body: some View {
        VStack {
            HStack {
                InputLabel(text: .TITLE_INPUT_FIELD_LABEL)
                TextField(PCLocale.getLocalizableString(of: .TITLE_INPUT_FIELD_PLACEHOLDER), text: $title)
            }
            DateInputRow(date: $startDate, label: .START_DATE_LABEL)
            DateInputRow(date: $endDate, label: .END_DATE_LABEL)
            Text(localized: .NOTES)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            TextEditor(text: $notes)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ModifyPlan_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPlan(title: .constant("Titler"),
                   startDate: .constant(Date()),
                   endDate: .constant(Date()),
                   notes: .constant("some notes"))
    }
}
