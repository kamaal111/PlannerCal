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
    let type: GeneralPlanColumnType
    let onPlanPress: (_ plan: CorePlan.RenderPlan) -> Void

    init(plans: [CorePlan.RenderPlan],
         type: GeneralPlanColumnType,
         onPlanPress: @escaping (_ plan: CorePlan.RenderPlan) -> Void) {
        self.title = type.title
        self.plans = plans
        self.type = type
        self.onPlanPress = onPlanPress
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            if type == .some(.general) {
                AddItemButton(action: {  })
                    .padding(.horizontal, 8)
            }
            ScrollView {
                ForEach(plans, id: \.self) { plan in
                    GeneralPlanColumnItem(plan: plan, onPress: { onPlanPress(plan) })
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.all, 16)
        }
    }
}

enum GeneralPlanColumnType {
    case unfinished
    case general

    var title: String {
        switch self {
        case .general: return PCLocale.Keys.GENERAL.localized
        case .unfinished: return PCLocale.Keys.UNFINISHED.localized
        }
    }
}

struct GeneralPlanColumn_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPlanColumn(plans: [], type: .general, onPlanPress: { _ in })
    }
}
