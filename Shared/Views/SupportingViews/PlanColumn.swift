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

    var body: some View {
        VStack {
            Text(date, formatter: Self.dayDateFormatter)
                .font(.headline)
                .foregroundColor(isShowing ? .primary : .secondary)
            Text(date, formatter: Self.dayNumberDateFormatter)
                .foregroundColor(isShowing ? .primary : .secondary)
        }
        .frame(maxWidth: width, maxHeight: .infinity, alignment: .top)
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
            PlanColumn(date: Date(), width: 100, isShowing: true)
            Color.primary.frame(maxWidth: 10)
            PlanColumn(date: Date(), width: 100, isShowing: false)
        }
    }
}
