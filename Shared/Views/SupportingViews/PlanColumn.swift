//
//  PlanColumn.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import SwiftUI

struct PlanColumn: View {
    let title: String
    let width: CGFloat

    var body: some View {
        VStack {
            Text(title)
        }
        .frame(minWidth: width, maxWidth: width, maxHeight: .infinity, alignment: .top)
    }
}

struct PlanColumn_Previews: PreviewProvider {
    static var previews: some View {
        PlanColumn(title: "Mon", width: 100)
    }
}
