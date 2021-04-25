//
//  LargeTextInputView.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 25/04/2021.
//

import SwiftUI
import PCLocale

struct LargeTextInputView: View {
    @Binding var text: String

    let label: String

    init(text: Binding<String>, label: String) {
        self._text = text
        self.label = label
    }

    init(text: Binding<String>, label: PCLocale.Keys) {
        self._text = text
        self.label = label.localized
    }

    var body: some View {
        VStack {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            TextEditor(text: $text)
        }
    }
}

struct LargeTextInputView_Previews: PreviewProvider {
    static var previews: some View {
        LargeTextInputView(text: .constant(""), label: "Notes")
    }
}
