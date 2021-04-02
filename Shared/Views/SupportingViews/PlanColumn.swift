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

    var body: some View {
        VStack {
            Text(date, formatter: Self.dayDateFormatter)
            Text(date, formatter: Self.dayNumberDateFormatter)
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
        PlanColumn(date: Date(), width: 100)
    }
}
