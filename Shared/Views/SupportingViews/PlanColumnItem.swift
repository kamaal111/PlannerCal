//
//  PlanColumnItem.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI

struct PlanColumnItem: View {
    @State private var isHovering = false

    let plan: CorePlan.RenderPlan
    let isPrimary: Bool
    let date: Date
    let onPress: () -> Void

    var body: some View {
        Button(action: onPress) {
            HStack {
                Text(plan.title)
                    .foregroundColor(titleColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if plan.original?.doneDate?.isSameDay(as: date) ?? false {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .disabled(!isPrimary)
        .buttonStyle(PlainButtonStyle())
        .onHover(perform: { (hovering: Bool) in
            if isPrimary {
                isHovering = hovering
            }
        })
    }

    private var titleColor: Color {
        if isPrimary {
            if isHovering {
                return .accentColor
            }
            return .primary
        }
        return .secondary
    }
}

struct PlanColumnItem_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        return PlanColumnItem(plan: .init(id: UUID(),
                                          startDate: date,
                                          endDate: date,
                                          doneDate: nil,
                                          title: "Titler",
                                          notes: "notes"),
                              isPrimary: true,
                              date: Date(),
                              onPress: { })
    }
}
