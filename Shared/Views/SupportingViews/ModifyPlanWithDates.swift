//
//  ModifyPlanWithDates.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI
import PCLocale

struct ModifyPlanWithDates: View {
    @Binding var title: String
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var notes: String

    var body: some View {
        VStack {
            TextInputRow(text: $title, label: .TITLE_INPUT_FIELD_LABEL, placeholder: .TITLE_INPUT_FIELD_PLACEHOLDER)
            DateInputRow(date: $startDate, label: .START_DATE_LABEL)
            DateInputRow(date: $endDate, label: .END_DATE_LABEL)
            LargeTextInputView(text: $notes, label: .NOTES)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}



struct ModifyPlanWithDates_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPlanWithDates(title: .constant("Titler"),
                            startDate: .constant(Date()),
                            endDate: .constant(Date()),
                            notes: .constant("some notes"))
    }
}
