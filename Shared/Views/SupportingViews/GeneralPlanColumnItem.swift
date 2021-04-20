//
//  GeneralPlanColumnItem.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 20/04/2021.
//

import SwiftUI

struct GeneralPlanColumnItem: View {
    @State private var isHovering = false

    let plan: CorePlan.RenderPlan

    var body: some View {
        HStack {
            Text(plan.title)
                .foregroundColor(titleColor)
            Spacer()
            Text(plan.endDate, style: .date)
                .foregroundColor(titleColor)
        }
        .buttonStyle(PlainButtonStyle())
        .onHover(perform: { hovering in
            isHovering = hovering
        })
    }

    private var titleColor: Color {
        if isHovering {
            return .accentColor
        }
        return .primary
    }
}

struct GeneralPlanColumnItem_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        return GeneralPlanColumnItem(plan: .init(id: UUID(),
                                                 startDate: date,
                                                 endDate: date,
                                                 title: "Titler",
                                                 notes: "notes"))
    }
}
