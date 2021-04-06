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
    let width: CGFloat
    let isPrimary: Bool
    let addItem: (_ date: Date) -> Void

    init(date: Date, width: CGFloat, isPrimary: Bool, addItem: @escaping (_ date: Date) -> Void) {
        self.date = date
        self.width = width
        self.isPrimary = isPrimary
        self.addItem = addItem
    }

    var body: some View {
        VStack {
            Text(date, formatter: Self.dayDateFormatter)
                .font(.headline)
                .foregroundColor(isPrimary ? .primary : .secondary)
            Text(date, formatter: Self.dayNumberDateFormatter)
                .foregroundColor(isPrimary ? .primary : .secondary)
            if isPrimary {
                Button(action: { addItem(date) }) {
                    HStack {
                        Text(localized: .ADD_ITEM)
                        Image(systemName: "plus")
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .frame(minWidth: Constants.planColumnMinimumWidth,
               maxWidth: width > Constants.planColumnMinimumWidth ? width : Constants.planColumnMinimumWidth,
               maxHeight: .infinity,
               alignment: .top)
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
        HStack {
            PlanColumn(date: Date(), width: Constants.planColumnMinimumWidth, isPrimary: true, addItem: { _ in })
            Color.primary.frame(maxWidth: 10)
            PlanColumn(date: Date(), width: Constants.planColumnMinimumWidth, isPrimary: false, addItem: { _ in })
        }
    }
}
