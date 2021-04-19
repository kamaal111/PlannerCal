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

    init(title: String) {
        self.title = title
    }

    init(title: PCLocale.Keys) {
        self.title = title.localized
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            ScrollView {
                ForEach((0..<20), id: \.self) { _ in
                    Text("Plan")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.all, 16)
        }
    }
}

struct GeneralPlanColumn_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPlanColumn(title: "General")
    }
}
