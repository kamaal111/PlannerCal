//
//  PlanSelectionInfoRow.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI
import PCLocale

struct PlanSelectionInfoRow: View {
    let label: String
    let value: String

    init(label: String, value: String) {
        self.label = label
        self.value = value
    }

    init(label: PCLocale.Keys, value: String) {
        self.label = label.localized
        self.value = value
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            Text(value)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PlanSelectionInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PlanSelectionInfoRow(label: .NOTES, value: "some cool\nnotes")
    }
}
