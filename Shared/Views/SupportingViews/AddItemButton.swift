//
//  AddItemButton.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 20/04/2021.
//

import SwiftUI

struct AddItemButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(localized: .ADD_ITEM)
                Image(systemName: "plus")
            }
        }
    }
}

struct AddItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButton(action: { })
    }
}
