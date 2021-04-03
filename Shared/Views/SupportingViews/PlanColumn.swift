//
//  PlanColumn.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import SwiftUI

struct PlanColumn: View {
    let date: Date
    let width: CGFloat
    let isShowing: Bool
    let addItem: (_ date: Date) -> Void

    init(date: Date, width: CGFloat, isShowing: Bool, addItem: @escaping (_ date: Date) -> Void) {
        self.date = date
        self.width = width
        self.isShowing = isShowing
        self.addItem = addItem
    }

    var body: some View {
        VStack {
            Text(date, formatter: Self.dayDateFormatter)
                .font(.headline)
                .foregroundColor(isShowing ? .primary : .secondary)
            Text(date, formatter: Self.dayNumberDateFormatter)
                .foregroundColor(isShowing ? .primary : .secondary)
            if isShowing {
                Button(action: { addItem(date) }) {
                    HStack {
                        Text("Add item")
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
            PlanColumn(date: Date(), width: Constants.planColumnMinimumWidth, isShowing: true, addItem: { _ in })
            Color.primary.frame(maxWidth: 10)
            PlanColumn(date: Date(), width: Constants.planColumnMinimumWidth, isShowing: false, addItem: { _ in })
        }
    }
}
