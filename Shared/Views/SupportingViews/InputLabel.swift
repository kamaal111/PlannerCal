//
//  InputLabel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI
import PCLocale

struct InputLabel: View {
    let text: String

    init(text: String) {
        self.text = text
    }

    init(text: PCLocale.Keys) {
        self.text = PCLocale.getLocalizableString(of: text)
    }

    var body: some View {
        Text(text)
            .frame(minWidth: 40, alignment: .leading)
    }
}

struct InputLabel_Previews: PreviewProvider {
    static var previews: some View {
        InputLabel(text: "Title")
    }
}
