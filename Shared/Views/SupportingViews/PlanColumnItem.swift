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
    let onPress: (_ plan: CorePlan.RenderPlan) -> Void

    var body: some View {
        Button(action: { onPress(plan) }) {
            Text(plan.title)
                .foregroundColor(titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .disabled(!isPrimary)
        .buttonStyle(PlainButtonStyle())
        .onHover(perform: { hovering in
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
        PlanColumnItem(plan: .init(id: UUID(), startDate: Date(), endDate: Date(), title: "Titler", notes: "notes"),
                       isPrimary: true,
                       onPress: { _ in })
    }
}
