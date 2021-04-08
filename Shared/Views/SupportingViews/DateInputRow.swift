//
//  DateInputRow.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 08/04/2021.
//

import SwiftUI
import PCLocale

struct DateInputRow :View {
    @Binding var date: Date

    let label: String

    init(date: Binding<Date>, label: String) {
        self._date = date
        self.label = label
    }

    init(date: Binding<Date>, label: PCLocale.Keys) {
        self._date = date
        self.label = PCLocale.getLocalizableString(of: label)
    }

    var body: some View {
        HStack {
            InputLabel(text: label)
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
            Spacer()
        }
    }
}

struct DateInputRow_Previews: PreviewProvider {
    static var previews: some View {
        DateInputRow(date: .constant(Date()), label: .START_DATE_LABEL)
    }
}
