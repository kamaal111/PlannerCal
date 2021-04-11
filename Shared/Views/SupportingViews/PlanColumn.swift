//
//  PlanColumn.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import SwiftUI
import PCLocale

struct PlanColumn: View {
    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme

    let date: Date
    let plans: [CorePlan.RenderPlan]
    let width: CGFloat
    let isPrimary: Bool
    let addItem: (_ date: Date) -> Void
    let onPlanPress: (_ plan: CorePlan.RenderPlan) -> Void

    init(date: Date,
         plans: [CorePlan.RenderPlan],
         width: CGFloat,
         isPrimary: Bool,
         addItem: @escaping (_ date: Date) -> Void,
         onPlanPress: @escaping (_ plan: CorePlan.RenderPlan) -> Void) {
        self.date = date
        self.plans = plans
        self.width = width
        self.isPrimary = isPrimary
        self.addItem = addItem
        self.onPlanPress = onPlanPress
    }

    var body: some View {
        VStack {
            Text(date, formatter: Self.dayDateFormatter)
                .font(.headline)
                .foregroundColor(dayTextColor)
            Text(date, formatter: Self.dayNumberDateFormatter)
                .foregroundColor(isPrimary ? .primary : .secondary)
            Button(action: { addItem(date) }) {
                HStack {
                    Text(localized: .ADD_ITEM)
                    Image(systemName: "plus")
                }
            }
            .disabled(!isPrimary)
            .padding(.horizontal, 8)
            VStack {
                ForEach(plans) { plan in
                    PlanColumnItem(plan: plan, isPrimary: isPrimary, onPress: onPlanPress)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                }
            }
            .padding(.vertical, 8)
        }
        .frame(minWidth: Constants.planColumnMinimumWidth,
               maxWidth: width > Constants.planColumnMinimumWidth ? width : Constants.planColumnMinimumWidth,
               maxHeight: .infinity,
               alignment: .top)
    }

    private var dayTextColor: Color {
        if date.isSameDay(as: Date()) {
            return .accentColor
        }
        if isPrimary {
            return .primary
        }
        return .secondary
    }

    static let dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()

    static let dayNumberDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter
    }()
}

struct PlanColumn_Previews: PreviewProvider {
    static var previews: some View {
        let plans: [CorePlan.RenderPlan] = []
        let date = Date()
        return Group {
            PlanColumn(date: date,
                       plans: plans,
                       width: Constants.planColumnMinimumWidth,
                       isPrimary: true,
                       addItem: { _ in },
                       onPlanPress: { _ in })
                .previewLayout(.sizeThatFits)
            PlanColumn(date: date,
                       plans: plans,
                       width: Constants.planColumnMinimumWidth,
                       isPrimary: false,
                       addItem: { _ in },
                       onPlanPress: { _ in })
                .previewLayout(.sizeThatFits)
        }
    }
}
