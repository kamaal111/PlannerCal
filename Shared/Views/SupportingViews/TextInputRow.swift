//
//  TextInputRow.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 25/04/2021.
//

import SwiftUI
import PCLocale

struct TextInputRow: View {
    @Binding var text: String

    let label: String
    let placeholder: String

    init(text: Binding<String>, label: String, placeholder: String) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
    }

    init(text: Binding<String>, label: PCLocale.Keys, placeholder: PCLocale.Keys) {
        self._text = text
        self.label = label.localized
        self.placeholder = placeholder.localized
    }

    var body: some View {
        HStack {
            InputLabel(text: .TITLE_INPUT_FIELD_LABEL)
            TextField(PCLocale.Keys.TITLE_INPUT_FIELD_PLACEHOLDER.localized, text: $text)
        }
    }
}

struct TextInputRow_Previews: PreviewProvider {
    static var previews: some View {
        TextInputRow(text: .constant(""), label: "Title", placeholder: "Fill me in!")
    }
}
