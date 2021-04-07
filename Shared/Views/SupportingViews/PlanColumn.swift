//
//  PlanColumn.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import SwiftUI
import PCLocale

struct PlanColumn: View {
    let date: Date
    let plans: [CorePlan.RenderPlan]
    let width: CGFloat
    let isPrimary: Bool
    let addItem: (_ date: Date) -> Void

    init(date: Date,
         plans: [CorePlan.RenderPlan],
         width: CGFloat,
         isPrimary: Bool,
         addItem: @escaping (_ date: Date) -> Void) {
        self.date = date
        self.plans = plans
        self.width = width
        self.isPrimary = isPrimary
        self.addItem = addItem
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
            ForEach(plans) { plan in
                Text(plan.title)
                    .foregroundColor(isPrimary ? .primary : .secondary)
            }
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
        return HStack {
            PlanColumn(date: date,
                       plans: plans,
                       width: Constants.planColumnMinimumWidth,
                       isPrimary: true,
                       addItem: { _ in })
            Color.primary.frame(maxWidth: 10)
            PlanColumn(date: date,
                       plans: plans,
                       width: Constants.planColumnMinimumWidth,
                       isPrimary: false,
                       addItem: { _ in })
        }
    }
}
