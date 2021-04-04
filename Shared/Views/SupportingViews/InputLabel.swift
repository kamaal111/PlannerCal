//
//  InputLabel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI

struct InputLabel: View {
    let text: String

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
