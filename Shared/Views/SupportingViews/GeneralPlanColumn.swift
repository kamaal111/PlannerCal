//
//  GeneralPlanColumn.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 18/04/2021.
//

import SwiftUI
import PCLocale

struct GeneralPlanColumn: View {
    let title: String
    let plans: [CorePlan.RenderPlan]

    init(title: String, plans: [CorePlan.RenderPlan]) {
        self.title = title
        self.plans = plans
    }

    init(title: PCLocale.Keys, plans: [CorePlan.RenderPlan]) {
        self.title = title.localized
        self.plans = plans
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            ScrollView {
                ForEach(plans) { plan in
                    HStack {
                        Text(plan.title)
                        Spacer()
                        Text(plan.endDate, style: .date)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.all, 16)
        }
    }
}

struct GeneralPlanColumn_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPlanColumn(title: "General", plans: [])
    }
}
